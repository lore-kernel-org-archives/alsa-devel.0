From: =?ISO-8859-2?Q?Lars_Hagstr=F6m?= <lars@update.uu.se>
Subject: Re: Creative Mp3+ USB and SPDIF passthrough
Date: Tue, 11 Nov 2003 14:18:04 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FB0E18C.7040309@update.uu.se>
References: <3FB0C937.30401@update.uu.se> <Pine.LNX.4.53.0311111315120.1303@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Okay! Two responses, I'll try them as soon as I can!

Lars

Jaroslav Kysela wrote:

> On Tue, 11 Nov 2003, [ISO-8859-1] Lars Hagström wrote:
> 
> 
>>Hi,
>>
>>I've sent this mail once before, but since I've received no response I
>>send it again (only this once, I wont keep spamming...).
>>
>>I've scoured the net, the alsa-user list and this mailing list for
>>information about how to enable AC3/DTS passthrough on the S/PDIF
>>connector on my new Creative Mp3+ USB box.
>>The only thing I've been able to find is a vague reference saying
>>something that spdif passthrough is not available in usb-audio. Is this
>>the truth? If it is the truth, will it remain so forever, or is anyone
>>working on it?
>>If it is not true, what am I doing wrong? I can get regular stereo
>>output on the digital out. I've got the box set to digital only, which
>>I've worked out is a requirement in windows. I have tried playing stuff
>>both with "aplay -Dspdif" (is this correct?)  and with "mplayer -ac hwac3".
> 
> 
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
> 						Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs
> 
> 
> -------------------------------------------------------
> This SF.Net email sponsored by: ApacheCon 2003,
> 16-19 November in Las Vegas. Learn firsthand the latest
> developments in Apache, PHP, Perl, XML, Java, MySQL,
> WebDAV, and more! http://www.apachecon.com/
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel



-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
