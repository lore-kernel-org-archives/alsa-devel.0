From: Gorm David Lai <lai@daimi.au.dk>
Subject: Re: problems with rme digi96/8
Date: 12 Jun 2003 12:36:01 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1055414161.16597.32.camel@duff>
References: <1054808252.7022.8.camel@duff>
	<200306111548.19324.torger@ludd.luth.se> <1055340198.1390.58.camel@duff>
	<200306111615.56664.torger@ludd.luth.se>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200306111615.56664.torger@ludd.luth.se>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Anders Torger <torger@ludd.luth.se>
Cc: Martin Langer <martin-langer@gmx.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2003-06-11 at 16:15, Anders Torger wrote:
> 
> Note that my example uses /dev/zero (zero input) so it should be silent. 
> Put something with sound in it instead of /dev/zero.
> 
> No, you shouldn't need to unmute the card (if you are not using analog 
> output), the digital output is just digital, no volume control for it 
> exists. A classical mistake is of course to connect ADAT input to ADAT 
> input, but I suppose you have checked that.
> 
> /Anders
> 
I thought so about the digital output, but wanted to make sure.
I know the ADAT is set up right, because everything works in Windows XP.

I tried your example. Aplay is rather stupid, so it is seems it needs a
soundfile with a equal amount of channels that can be allocated on the
card; in this case 8.
As far as i know wave files only support stereo. So i tried feeding it
noise, like

aplay -D hw:0,1 -r 44100 -f S16_LE -c 8 ~/plg-second-printing-update.ps

aplay starts to play with the output:

Playing raw data '/users/lai/plg-second-printing-update.ps' : Signed 16
bit Little Endian, Rate 44100 Hz, Channels 8

But no sound. I am nearly giving up now...

/Gorm





-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
