From: Kris Modrak <u9514439@anu.edu.au>
Subject: Re: Rate Conversion
Date: Fri, 28 Jun 2002 13:30:24 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D1BD850.C59C43C2@anu.edu.au>
References: <Pine.LNX.4.33.0206271610220.545-100000@pnote.perex-int.cz>
Reply-To: u9514439@anu.edu.au
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> 
> On Thu, 27 Jun 2002, Kris Modrak wrote:
> 
> > I am writing a PCM application and wish to play a .wav file that has a
> > sampling rate of 8kHz on a hardware setup that only supports sampling
> > frequencies of 44.1 or 48kHz.
> >
> > Does anyone know how to implement this?
> 
> You don't need to do this. Use the 'plughw' device which should do all
> conversions from you.

I am a little confused about your advice. I am not sure how to access
the 'plughw' device from my application.

I have a full duplex application that can play a file at 44.1kHz and
record at the same rate but I want it to operate at lower sampling
frequencies.

I am not sure of how I should be setting up my PCM devices. How do I
tell them to convert, say, 8kHz audio data to 44.1kHz audio data so my
hardware can play it at the correct speed?

I tried using aplay with plughw to play an 8kHz file and got the
following results

>aplay -Dplughw s1.wav
Playing WAVE 's1.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
Segmentation fault

However it worked when using a 441.kHz file.

Regards
Kris Modrak


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Bringing you mounds of caffeinated joy.
http://thinkgeek.com/sf
