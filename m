From: =?ISO-8859-2?Q?Lars_Hagstr=F6m?= <lars@update.uu.se>
Subject: Re: Creative Mp3+ USB and SPDIF passthrough
Date: Wed, 12 Nov 2003 19:58:07 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FB282BF.6060100@update.uu.se>
References: <3FB0C937.30401@update.uu.se> <Pine.LNX.4.53.0311111315120.1303@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.53.0311111315120.1303@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

You were right of course. It works beautifully. Thank you very much!
So, just for the record, so that anyone else out there trying to get 
this device to work in the future will be able to find it:

The Creative Mp3+ USB device output works completely under Alsa (I've 
not tried input).
To get ac3 passthrough you need to get an ac3 file and use
  ac3dec -Dhw:0,0 -C <your_ac3_file>
You can play media with ac3 in mplayer with the  oss compatibility layer 
(mplayers alsa driver does not seem to be able to passthrough) using:
mplayer -ao oss:/dev/dsp -ac hwac3 <your file>

Lars

> You have wrong tests. Get alsa-tools, compile ac3dec and try this command:
> 
> ac3dec -Dhw:0,0 -C <your_ac3_file>
> 
> The volumes (probably PCM and Master) should be set to 0dB (you need
> probably trial and error path to determine the good values), otherwise
> the stream will be modified and the receiver will not understand. Simply,
> you need bit-to-bit copy without any modification of outgoing samples.
> 
> Anyway, it might be possible, that your receiver does rely on the
> non-audio bit set in the s/pdif protocol. In this case, we cannot help you
> until someone discover, how this settings can be applied to your hardware.
> 



-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
