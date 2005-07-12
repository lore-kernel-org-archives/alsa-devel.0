From: Brian Black <BlackBsd@Mountain.Net>
Subject: Sound Programming Issues
Date: Mon, 11 Jul 2005 21:13:18 -0400
Message-ID: <42D3192E.9090700@Mountain.Net>
Reply-To: BlackBsd@Mountain.Net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

hi,
~    i recently posted about an issue i was having with my alsa sound
app.  I wanted to do a follow up to try to make my issue more clear,
as my first post was not as clear.

The issues i am having using the code in AlsaPlay function come when i
try calling the function with different datasize argument.

the line in Main.cpp
~    long m = wfile.GetSize()/40;

is the line that i am changing when i am noticing the issue.  .GetSize
is for the wave file i am using is returning 331776.

the logic is
~    NumberOfBytesToRead = m

~    while( n< wfile.GetSize())

~       wfile.Read(DestBuffer, NumberOfBytesToRead)

~         AlsaPlay(DestBuffer, NumberOfBytesToRead)

~          n+=NumberOfBytesToRead

and by making m some other number (Less than .GetSize of course), the
sound comming out of the AlsaPlay function is not the same

for example the file size of the file i am using is 331776, and when i
make m= .GetSize/10 there is static in the output, When it is
m=.GetSize/40 it sound fine.

As i mentioned in my previous post.  when the AlsaPlay function gets
called and i begin to go into my loop to play sounds i do have a value
of -22 (Invalid argument) returned by my snd_pcm_writei.  This mostly
happens on the first snd_pcm_writei call, from the second AlsaPlay
function untill all the data has been played, Though i have seen the
error at other times in the loop.


Just a note to make so i am honest.  i am using some low end dell pc
at work where i am noticing these issues.  the driver i am using at
work is intell8x0 for the onboard sound.

Now at home(where i am at typing this email), i have an audigy 2. and
i do not have the issues with the -22 return code but if i make m =
.Getsize / (8-above).  my program goes into some blocking state.

Thread [1] (Suspended: Signal 'SIGINT' received. Description: Interrupt.)
~    21 ioctl()
~    20 snd_pcm_hw_fast_tstamp()
~    19 <symbol is not available>
~    18 alsa_lisp_init_objects()
~    17 <symbol is not available>
~    16 <symbol is not available>
~    15 <symbol is not available>
~    14 <symbol is not available>
~    13 <symbol is not available>
~    12 <symbol is not available>
~    11 <symbol is not available>
~    10 <symbol is not available>
~    9 <symbol is not available>
~    8 snd_pcm_writei()
~    7 <symbol is not available>
~    6 <symbol is not available>
~    5 <symbol is not available>
~    4 ftrylockfile()
~    3 <symbol is not available>
~    2 _dl_argv()
~    1 AlsaPlay() at AlsaPCM.c:457


Wow, can i compile the alsalib for debugging so i may step through?

Anyways below is some output from a typical run of my program (From
home with m= .Getsize/7)

Max buffer time is: 743039.
Wrote 5513 bytes of data to device.
Wrote 5513 bytes of data to device.
Wrote 5513 bytes of data to device.
Wrote 5513 bytes of data to device.
Wrote 1646 bytes of data to device.
Leaving Function............
Wrote 5513 bytes of data to device.
Wrote 5513 bytes of data to device.
Wrote 5513 bytes of data to device.
Wrote 5513 bytes of data to device.
Wrote 1646 bytes of data to device.
Leaving Function............
Wrote 5513 bytes of data to device.
Wrote 5513 bytes of data to device.
Wrote 5513 bytes of data to device.
Wrote 5513 bytes of data to device.
Wrote 1646 bytes of data to device.
Leaving Function............
Wrote 5513 bytes of data to device.
Wrote 5513 bytes of data to device.
Wrote 5513 bytes of data to device.
Wrote 5513 bytes of data to device.
Wrote 1646 bytes of data to device.
Leaving Function............
Wrote 5513 bytes of data to device.
Wrote 5513 bytes of data to device.
Wrote 5513 bytes of data to device.
Wrote 5513 bytes of data to device.
Wrote 1646 bytes of data to device.
Leaving Function............
Wrote 5513 bytes of data to device.
Wrote 5513 bytes of data to device.
Wrote 5513 bytes of data to device.
Wrote 5513 bytes of data to device.
Wrote 1646 bytes of data to device.
Leaving Function............
Wrote 5513 bytes of data to device.
Wrote 5513 bytes of data to device.
Wrote 5513 bytes of data to device.
Wrote 5513 bytes of data to device.
Wrote 1646 bytes of data to device.
Leaving Function............
Wrote 38 bytes of data to device.
Leaving Function............


Hope that helps, as i am a noob and am stuck.

thanx
brian
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD4DBQFC0xkusFNeVVLY1KsRAqrFAJ9sEz0RmmDU5vP3/5Is2F66+uen7ACYikzC
kvRc6Sip/EGlheiQyfboVQ==
=qDDG
-----END PGP SIGNATURE-----



-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
