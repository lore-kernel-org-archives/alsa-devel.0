From: Giuliano Pochini <pochini@shiny.it>
Subject: RE: trigger problems.
Date: Wed, 14 Jul 2004 15:36:22 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20040714153622.pochini@shiny.it>
References: <40F52C9D.60704@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40F52C9D.60704@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


On 14-Jul-2004 James Courtier-Dutton wrote:
> I am writing a alsa driver for the audigyls and p16v.
> The output on these sound cards can work in 1 of two ways.
> 1) 1 substream with 8 channels, and one interrupt request per period.
> For 5.1 output, we just use alsa.conf to map the user's application 
> channels into the correct channels of the 8 channel substream.

This is the simplest method of handling several channels, but you
waste some of them.


> 2) 4 substreams with 2 channels each.
> For 5.1 output, we just use 3 substreams, front, rear, center_lfe.
> The problem with this is that we then have a separate interrupt per
> substream, resulting in 3 times more interrupts. The substreams are also
> not in sample sync with each other, because the trigger for each
> substream is executed one after the other, instead of in one go.

You lose stereo image if the channels are out of sync. It also depends
on how much they are. It's generally a bad thing.


> So, because of this, I have a feature request for alsa-driver.
> If a user app opens the sound device in such a way that a single stream 
> from the app gets converted into multiple substreams to the same sound 
> card hardware, can we have a single trigger call for all substreams.

It's already possible. Grep the drivers sources for snd_pcm_set_sync()
and snd_pcm_trigger_done().  Some of them already use that feature.
Also, userspace must explicitly use it.  Have a look at the example
program latency.c (alsa-tools ?)


--
Giuliano.


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
