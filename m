From: Arnaud Patard <apatard@mandriva.com>
Subject: Re: HDA pin sense and presence detect capability
Date: Wed, 25 Jan 2006 18:32:53 +0100
Message-ID: <m37j8op60q.fsf@anduin.mandrakesoft.com>
References: <m3k6copbi9.fsf@anduin.mandrakesoft.com>
	<s5hu0bsb9du.wl%tiwai@suse.de>
	<m3fyncpar3.fsf@anduin.mandrakesoft.com>
	<20060125090825.B29602@cox.net>
	<m3bqy0p7n9.fsf@anduin.mandrakesoft.com>
	<20060125101422.D29602@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from office.mandriva.com (ezoffice.mandriva.com [84.14.106.134])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 52B50199
	for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2006 18:31:04 +0100 (MET)
In-Reply-To: <20060125101422.D29602@cox.net> (Matt Porter's message of "Wed,
	25 Jan 2006 10:14:22 -0700")
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Matt Porter <mporter@embeddedalley.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Matt Porter <mporter@embeddedalley.com> writes:

> On Wed, Jan 25, 2006 at 05:57:46PM +0100, Arnaud Patard wrote:
>> Matt Porter <mporter@embeddedalley.com> writes:
>> 
>> > On Wed, Jan 25, 2006 at 04:50:40PM +0100, Arnaud Patard wrote:
>> >> About what's done in patch_sigmatel.c : what's the point of disabling
>> >> the output ? imho, you only need to mute the nid. 
>> >
>> > It seemed easier to disable the actual pin nid outputs for all line outs
>> > (thing surround) than walk back to the associated DAC nids (which can
>> 
>> I see... but afaik, muting the DAC is not the solution because you may
>> have one DAC with the HP and speakers nids connected to it (for instance
>> on the ad1981hd). My point was about muting the nid itself. 
>
> Indeed, that's the other reason for not doing it that way. What do
> you mean by "muting the nid itself"? The pin widget nid? There's no
> mute on the sigmatel codec pin widgets since there's no amp capability
> there. Disabling the output is the way to mute at the pin widget...
> at least on sigmatel hda codecs.

oh okay. I was (wrongly) thinking that you were having amp capability
like here. So, your solution is probably better as it'll work in all
cases imho

>
>> > vary on sigmatel codecs) and mute those. It accomplishes the same
>> > thing as muting...except there's no change in mixer state.
>> 
>> Reflecting a change in the mixer state is more userfriendly but as long
>> as it's working as the user expects, that's not a real worry.
>
> Yeah, I wasn't sure about that. On the sigmatel codecs, the output
> amps are in the DAC nids so we'd have to mute all of them in an
> associated group if this is the desired userfriendly view of things.
> Not a big deal to do, just not as simple as my first pass.
>
>> >> Also, if there are several users of similar functions and on others chips than
>> >> sigmatel, shouldn't it be better to put something in hda_codec.c ?
>> >  
>> > I think so, but this was somewhat of an experimental first attempt
>> > at this support. I just haven't had time to do much more with it yet.
>> 
>> okay. I'm trying to have something working for my codec and then I'll
>> try to work on this. If you don't agree, scream :)
>
> I think it's great. Sounds like Takashi wants to see more shared
> code as well and his opinion if far more important. ;)

sure :)


Regards,
Arnaud



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
