From: "Ivica Bukvic" <ico@fuse.net>
Subject: CS4205 -- personal conclusion: avoid these laptops (for now)...
Date: Mon, 6 May 2002 17:45:24 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <ab6tjh$d10$2@main.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all!

I've just finished messing with the Inspiron 8200, and after 2 weeks of
messing with it and 4 different OS's (Deb, Mdk, RH/beta, and currently
Suse), I can say that this card is simply not ready to be used seriously
for the pro audio with Alsa. Here's the final breakdown of everything I
learned so far:

OSS/Free -- don't bother, it's not even full-duplex

ALSA -- works (sort of), it reports 4 modprobe errors using intel8x0
driver prior to firing-up soundcard, resulting in 4 loud "clicks." It
can play only one stream at the time, so it does not provide even basic
mixing capabilities (i.e. multiple Csound or RTcmix streams, and/or
multiple apps). Even Maestro 3i had 2 streams going. There are also some
buffering issues which are hard to pinpoint (sometimes sound clips more
when the buffer is larger, than when it's smaller).

This is not to say that Alsa is bad, please do not get me wrong, I am a
die-hard Alsa proponent and will remain to be one, it just seems that
for right now, this card is not usable with Alsa.

In addition, if one tries to use artsd, somehow artsd is unable to get
the mic-input for full-duplex operations on most of the apps (not sure
though if this is app's problem or Alsa's, but from current symptoms my
guess is Alsa's).

Finally, we have commercial OSS, which I hate to admit does support 2
audio streams (only via artsd, but at least it manages to send the mic
input for full-duplex sound processing twice through artsd), although
invoking of the third full-duplex one trashes the sound (or second one
without artsd).

I have luckily an eval laptop from Dell, so I will try to put some
pressure at them to provide Alsa with a more complete documentation
(obviously they will have to pester Intel or CS, whoever is responsible
for this stuff). Can't promise anything, but it's worth the try. I would
like to encourage anyone else who is in the same boat to do the same.
And don't let Dell support to tell you that Linux is not supported,
because it is on Latitude series which are practically identical to
Inspirons (i.e. Inspiron 8200 = Latitude C800 or whatever its name is).
They should not be allowed to advertise their laptops as Linux friendly
when they are not entirely (or not enough soundwise at least).

Ico



_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
