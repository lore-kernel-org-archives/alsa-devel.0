From: drclaw@dogsolitude.org
Subject: Re: How to play different audio data on the left and right channel at the same time?
Date: Sat, 21 Dec 2002 13:42:03 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021221184203.GA25234@dogsolitude.org>
References: <F17tIzmQVuRWCy7rjcx0000d3e2@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <F17tIzmQVuRWCy7rjcx0000d3e2@hotmail.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: flyingwalter@msn.com
List-Id: alsa-devel@alsa-project.org

On Sat, Dec 21, 2002 at 08:02:19PM +0800, ??? ??? wrote:
> Hi,
>  I want to play different wave file on two channel at the same time, that's 
> one wave file for left channel, and the other for right channel, can I 
> achieve this with the alsa lib on linux? Need I open the sound device twice?
>  Thx!
> 

Well, there are 2 ways to do this:

1. The Programming Way:  Just interleave the samples from each wav, in
other words, lets call your 2 files left.wav and right.wav.  Feed your
soundcard a stream of samples that go left.wav[sample0],
right.wav[sample0], left.wav[sample1], right.wav[sample1], etc...  Just
remember that it goes left, right, left, right, etc.  

2. The Non-Programming Way:  Open up your favorite wav editor and assign
one wav to the left channel and one wav to the right channel and save
it.  This is the way you'd do it if you only had a few of these double
wav's that you wouldn't have to change much.  If you have a lot of them
and need to make fast decisions about what you're doing, you can use the
command line program SoX to pan each in either direction and play them
simultaneously.  I can't think of the specific options but you can find
them in the SoX manpage, SoX seriously does *every* simple operation
you'd want to perform on an audio file.  

I hope this helps,

784 - Michael C. Piantedosi - drclaw@dogsolitude.org


-------------------------------------------------------
This SF.NET email is sponsored by: Order your Holiday Geek Presents Now!
Green Lasers, Hip Geek T-Shirts, Remote Control Tanks, Caffeinated Soap,
MP3 Players,  XBox Games,  Flying Saucers,  WebCams,  Smart Putty.
T H I N K G E E K . C O M       http://www.thinkgeek.com/sf/
