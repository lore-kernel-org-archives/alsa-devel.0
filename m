From: Josh Lehan <alsa@krellan.com>
Subject: Re: [PATCH - alsa-utils 5/5] The amidicat program
 itself, better late than never
Date: Tue, 08 Jul 2014 22:26:15 -0700
Message-ID: <53BCD277.3040908@krellan.com>
References: <1404118503-22921-1-git-send-email-alsa@krellan.com>
 <1404118503-22921-6-git-send-email-alsa@krellan.com>
 <1404863718.378573458@f135.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www7.pairlite.com (www7.pairlite.com [64.130.10.17])
 by alsa0.perex.cz (Postfix) with ESMTP id E9C88261B03
 for <alsa-devel@alsa-project.org>; Wed,  9 Jul 2014 07:26:17 +0200 (CEST)
In-Reply-To: <1404863718.378573458@f135.i.mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergey <sergemp@mail.ru>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 07/08/2014 04:55 PM, Sergey wrote:
> Jun 30 2014, Josh Lehan wrote:
>> Signed-off-by: Josh Lehan < alsa@krellan.com >
>>
>> diff --git a/amidicat/amidicat.c b/amidicat/amidicat.c
> 
> This is kind of a bugreport for amidicat.
> 
> I tested amidicat. The first use case I thought was:
> [remotehost]$ timidity -iA -Os -B2,8 &
> [remotehost]$ nc -l -p 12345 | amidicat --port 129:0 --noread --verbose --hex
> [localhost]$ vkeybd &
> [localhost]$ amidicat --port 128:0 --nowrite --verbose --hex | nc remotehost 12345
> 
> But that have not worked from the beginning.

I tried that myself, and ran into problems, you're right.

1) Subscribers vs. direct

There seems to be a limitation in vkeybd, or a bug in how amidicat
connects to vkeybd (but I can't find where the bug might be in amidicat,
it seems to be calling ALSA correctly).

The limitation is this: When vkeybd is ran without the --addr argument
(in "subscribers" mode), vkeybd won't send data.  You hit the keys and
nothing is sent.

This doesn't happen on a real synthesizer keyboard hooked up to ALSA, I
believe (this needs more testing, though).

However, when vkeybd is ran with --addr, explicitly connecting to
another ALSA port (not in "subscribers" mode), it works just fine then!
 To do this, though, you have to start amidicat first, note the ALSA
port that it has received, then start vkeybd after that, using that as
the --addr argument to vkeybd.

Somehow, the aseqdump program overcomes this limitation, though!  I need
to figure out how it does that.  I think it has something to do with how
the connection is made: simultaneously acting as both a direct
connection and a subscription connection at the same time.

2) Unwanted buffering with --hex

My bug here, good catch.  I'm not flushing streams often enough, so
unwanted buffering takes place.  In the default mode (binary output),
amidicat uses write(), so output is entirely untouched by stdio.
However, when --hex is used, I'm using printf() instead of write()!
Easy fix, just haven't done it yet.

3) Confusing options

Assuming bug above is fixed, I'm thinking of making --hex the default,
and adding the --binary option to get the previous default of raw binary
output.  Similarly, make --verbose the default, with corresponding
--quiet option.

Also, some recalcitrant programs (like timidity and vkeybd) are very
picky about ALSA permissions when trying to make a connection.  The
--noread and --nowrite options have to be used way too often, and they
are annoying and restrictive.

I'm thinking of having amidicat automatically probe for permissions by
default, so the user doesn't need to manually apply the --noread and
--nowrite constraints.  Upon encountering permissions failure, it would
give up the direction of I/O through ALSA that failed, either input or
output, as if the user had specified --noread or --nowrite, thus
reducing required permissions automatically, but otherwise carry on as
normal.

However, if this is to become the default, the user should have a way of
requiring that a successful read or write connection be made, such as
--requireread or --requirewrite.  The reason is that silently ignoring
permissions failures might lead to unwanted/surprising behavior, and
user might want to guard against this.

An example of surprising behavior is that when input is closed, you have
to provide the --wait option to amidicat, otherwise it doesn't know how
long to keep running for.  Usually, closure of input is what notifies
the program to stop running.  Reason for choosing to do it this way was
that I didn't want the program to simply block forever if it has nothing
more to do, as that would cause any callers to also block.  The
--nowrite option defeats this, though, causing the program to run
forever until manually stopped.  Should simplify this as well, calling
it --linger instead of --wait would make more sense.

4) Permissions backwards

Also, what about ALSA permissions that amidicat itself advertises?  To
make a long story short, I think I have this backwards.  No wonder the
above options are confusing, they don't work as originally intended!

Try this workflow, it should work:

[remotehost]$ timidity -iA -Os -B2,8 &
[remotehost]$ nc -l -p 12345 | amidicat --port "TiMidity" --noread --verbose
[localhost]$ amidicat --verbose --wait 300 < /dev/null | nc remotehost
12345 &
[localhost]$ vkeybd --addr 999:0

On localhost, replace 999:0 with the actual ALSA port you see on your
terminal (amidicat will show it to you by writing to standard error)
before starting vkeybd.

I'm referencing TiMidity by name instead of by number, which is a safer
behavior to do, since numbers often change.

I'm using binary, not hex, to work around the blocking bug for now (this
will shortly not be necessary).

On localhost, I had to give "< /dev/null" because otherwise I wouldn't
be able to disassociate standard input from the terminal, a requirement
for successfully running in the background.  This necessitated the use
of the --wait option, which I'm not happy about, because it imposes a
time limit.  I wouldn't have needed it if I could have given the
--nowrite option, however, if I did this, it wouldn't advertise ALSA
write permission to other programs.  The vkeybd program requires write
permission.

> First, I noticed that "amidicat" is not listed in `aconnect -iol` output. Why?

That's strange, it's showing up just fine for me.  Here's my output:

client 0: 'System' [type=kernel]
    0 'Timer           '
    1 'Announce        '
	Connecting To: 15:0
client 14: 'Midi Through' [type=kernel]
    0 'Midi Through Port-0'
client 128: 'TiMidity' [type=user]
    0 'TiMidity port 0 '
    1 'TiMidity port 1 '
    2 'TiMidity port 2 '
    3 'TiMidity port 3 '
client 129: 'amidicat' [type=user]
    0 'amidicat        '

> Also, it prints nothing in the following case:
> $ vkeybd &
> $ amidicat --port 128:0 --nowrite --verbose --hex
> except initial "Connected to ALSA sequencer on port 130:0" line
> which itself looks suspicious, since I asked it to connect on port 128:0.

That's a point of confusion.  There's two ALSA ports in the above
example: port 128 (I assume this is vkeybd), and port 130 (amidicat).

When it starts up, the amidicat program is assigned port 130 by ALSA,
and this port number is not knowable until runtime, which is why it's
printed at runtime.  It will still make an outbound connection to the
port you specified, which is port 128, though.  It's just like a TCP
connection on the Internet: in order to communicate, you must have both
a source port number and a destination port number.

I probably should add a --localport option, to make this more explicit
(and give you the opportunity to request a known local port number
instead of having to take whatever ALSA randomly assigns).

> However `aseqdump` works like that:
> $ vkeybd &
> $ aseqdump -p 128:0

The --port option of amidicat should be equivalent to the -p option of
aseqdump.

> Even more interesting test: run them all.
> [console1]$ vkeybd &
> [console1]$ aseqdump -p 128:0
> press a key, as expected I see:
> 128:0 Note on 0, note 60, velocity 127
> 128:0 Note off 0, note 60, velocity 0
> while `aseqdump` is still running in another terminal I start `amidicat`:
> [console2]$ amidicat --port 128:0 --nowrite --verbose --hex
> then press a few keys and in aseqdump terminal I see:
> 128:0 Note on 0, note 60, velocity 127
> 128:0 Note on 0, note 60, velocity 127
> 128:0 Note on 0, note 60, velocity 127
> 128:0 Note on 0, note 60, velocity 127
> 128:0 Note on 0, note 60, velocity 127
> 128:0 Note on 0, note 60, velocity 127
> 128:0 Note on 0, note 60, velocity 127
> 128:0 Note on 0, note 60, velocity 127
> how could that be? I pressed different keys, why same "Note on"?
> then I interrupt `amidicat` with Ctrl+C and instantly see:
> 128:0 Note on 0, note 60, velocity 127
> 128:0 Note off 0, note 60, velocity 0
> 128:0 Note on 0, note 62, velocity 127
> 128:0 Note off 0, note 62, velocity 0
> 128:0 Note on 0, note 64, velocity 127
> 128:0 Note off 0, note 64, velocity 0
> 128:0 Note on 0, note 65, velocity 127
> 128:0 Note off 0, note 65, velocity 0
> 128:0 Note on 0, note 67, velocity 127
> 128:0 Note off 0, note 67, velocity 0
> amidicat terminal was still empty, nothing except initial "Connected to ..." line.

I'm surprised about that as well.  Multiple copies of aseqdump can be
ran at the same time, and everything still works (ALSA correctly
multiplexes the output of vkeybd to all interested subscribers).

However, this doesn't work for amidicat, and that's a bug.  When
amidicat is running, ALSA blocks delivery of vkeybd events to the
aseqdump clients.  When amidicat exits, this blockage clears, and all
the blocked events are suddenly delivered to aseqdump (that's why you
get the flood of output in aseqdump when amidicat exits).  Obviously,
amidicat is doing something wrong, and confusing ALSA.

> Expected results:
>   amidicat prints events from vkeybd
>   does not affect other apps, e.g. aseqdump
>   and is listed in `aconnect -iol` output

Agreed.

> Note: I tested that on debian oldstable with alsa 1.0.23, could that be the reason?
> Can you reproduce that on your system?

As above, I can reproduce the vkeybd and aseqdump bugs/limitations.

However, I can't reproduce "aconnect -iol", it works fine for me, I see
amidicat correctly listed in the output.

Also, try "amidicat --list", which will give you output similar to
"aplaymidi -l" but include more devices (unlike aplaymidi, amidicat does
no filtering, it shows you everything, even including itself in the list).

The list of devices should be the same for both aconnect and amidicat,
however, since amidicat includes itself in the listing, you will see an
additional entry for that as well.

> Thank you for an interesting tool.

You're welcome!

I'm proud of the program, it fills a useful niche.

Thanks for testing.  You've exposed some bugs, and use cases I hadn't
thought about, so it's back to the drawing board for me, and I hope to
have an updated version finished soon.

Josh Lehan
