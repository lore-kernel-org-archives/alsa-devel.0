From: "Ash Willis" <ashwillis@programmer.net>
Subject: anyone want to help me with something?
Date: Wed, 30 Jun 2004 14:56:09 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040630195609.DDC9B790052@ws1-14.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi, i'm writing a driver for a card and i've got it initialising and it sets up the ac97. However the pcm does nothing at the moment...

I don't really know what i'm asking, i'm just stuck :)

When i try to write to /dev/dsp i see that the driver's playback, hw_free, and close ops are executed.
but when i look at everyone's else's code for these ops, no data is transferred to the card.
I know the dma transfer should take place in the prepare callbacks, but they don't seem to get called. When SHOULD these callbacks run?
So yeah, i'm just a bit confused...how when i write to dsp the prepare callback isn't run.

I just need to know how this thing works. could it just be that i've got an error somewhere that stops the callback running or am i just confused and it's not even supposed to be run at this time.

I'd appreciate any help anyone can give me on making this a little clearer. It's cool even if someone could jsut refer me to the alsa code for me to just read, but i just didn't fancy having to wade through ALL of it.

Thanks a lot for any help,
Ash Willis
-- 
___________________________________________________________
Sign-up for Ads Free at Mail.com
http://promo.mail.com/adsfreejump.htm




-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
