From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: RME DSP / Multiface documentation? (hdsp.c)
Date: Tue, 12 Nov 2002 10:36:53 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18Bd33-0007Fr-00@usw-sf-list1.sourceforge.net>
References: <3DD112F4.B4A84A07@users.sourceforge.net>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 12 Nov 2002 16:40:52 +0200."
             <3DD112F4.B4A84A07@users.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "M. Nentwig" <nentwig@users.sourceforge.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>- In snd_hdsp_interrupt: The first four lines determine, why the
>interrupt was triggered (audio, midi0, midi1). Now the MIDI code further
>down does not use that information, but the MIDI status instead. 

this is necessary because there is no interrupt for "output space
available" on the MIDI ports. therefore, its necessary to check the
FIFO's to see if there is space. however, its true that the code there
is a bit bone-headed. 

it should really check both in+out FIFO status, and then only call the
MIDI code if one or both is true *and* if the relevant MIDI IRQ
pending bit was set.

this is orthogonal to the tasklet/BH issue i just mentioned.

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
