From: "PIVATY Bertrand" <bertrand.pivaty@eurocontrol.int>
Subject: RE: Urgent question
Date: Mon, 9 Jan 2006 15:04:34 +0100
Message-ID: <0AEFDFCCEC85B24E8051B23293C2CB640F2506@MMMSTCAE1.muac.corp.eurocontrol.int>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Habets <errandir_news@mph.eclipse.co.uk>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello all,

Thanks for your quick reaction.

aplay and speaker produce the same good quality on both onboard and PCI
sound cards.

It is indeed for us obvious that the problem is coming from the audio
software.

But when checking the source code, I didn't see anything special, I mean
they mainly use the ALSA api, and it is basically looks like the
different ALSA tutorials that I've found.

This is a software from one of our provider, and I know that the code
was ported from SUN microsystem to Linux to meet our requirements, there
are some statements with "ioctl" calls, do you think that this could be
an issue, as it bypass the ALSA api?

I know it seems vague, but I can try to send some part of the code with
ALSA (I think this is not a big issue, the only thing is I don't know
witch part could be interesting to send).

We also made some test with some usb sound cards with the same
hardware/software, and the sound look better.

Here the information you asked for:

Linux MASTER 2.4.21-99-default #1 Wed Sep 24 13:30:51 UTC 2003 i686 i686
i386 GNU/Linux

Advanced Linux Sound Architecture Driver Version 1.0.5a.
Compiled on Jan 16 2006 for kernel 2.4.21-99-default with versioned
symols


-----Original Message-----
From: alsa-devel-admin@lists.sourceforge.net
[mailto:alsa-devel-admin@lists.sourceforge.net] On Behalf Of Martin
Habets
Sent: Monday 09 January 2006 12:28
To: alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] Urgent question

On Mon, Jan 09, 2006 at 11:07:36AM +0100, PIVATY Bertrand wrote:
> The sound quality looks good when using the onboard sound card
provided,
> but when using any PCI sound card the sound quality is really poor.

Have you tried different PCI cards? Or is the issue with a specific
model or chipset?

> Do you have any idea of what could be the reason, or any track where
we
> should investigate.

The first obvious step is to figure out if it is an application problem
or a kernel/alsa issue. I usually run 'aplay' or 'speakertest' with a
simple
test file to figure that out.
If these work okay it's most likely an application problem.

> The software is running on Suse 9.0 with the last Alsa version.

This does not mean a whole lot to me. Could you send the kernel and alsa
version as reported by uname and /proc/asound/version?

--=20
Martin


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log
files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=3D7637&alloc_id=3D16865&op=3Dclick
_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
____

This message and any files transmitted with it are legally privileged and=
 intended for the sole use of the individual(s) or entity to whom they ar=
e addressed. If you are not the intended recipient, please notify the sen=
der by reply and delete the message and any attachments from your system.=
 Any unauthorised use or disclosure of the content of this message is str=
ictly prohibited and may be unlawful.

Nothing in this e-mail message amounts to a contractual or legal commitme=
nt on the part of EUROCONTROL unless it is confirmed by appropriately sig=
ned hard copy.

Any views expressed in this message are those of the sender.
=0D


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
