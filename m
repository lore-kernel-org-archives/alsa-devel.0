From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: How to put 16bit none audio PCM data stream into
 a 32bit none audio S/P-DIF transport stream?
Date: Thu, 10 Apr 2003 18:43:53 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E95AD59.30900@superbug.demon.co.uk>
References: <20030408140230.GA1987@ulima.unil.ch> <E192u0x-0007pF-00@sc8-sf-list1.sourceforge.net> <s5hn0j1q97r.wl@alsa2.suse.de> <20030408164241.GA4253@ulima.unil.ch> <3E933167.6010300@superbug.demon.co.uk> <3E93F74C.20607@superbug.demon.co.uk> <20030409110606.GD14489@ulima.unil.ch> <3E944F52.3040406@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E944F52.3040406@superbug.demon.co.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:

> Well, I have downloaded
> http://www.skwmedia.com/media/diatonis/ac3/diatonis_last_summer_rain_ac3_256kbps.zip
>
> It says that the files available before have been removed because they 
> appeared to be corrupt.
> My it is a corrupt file you are working with.
>
> Cheers
> James
>
>
>
To help you. In order to play this ac3 file, unzip it and you will get a 
.wav file.
Then use this command to send it to the SPDIF socket in non-audio 
passthru mode for your external AC3 decoder to recognise.
aplay -D "iec958:AES0=0x6,AES1=0x82,AES2=0x0,AES3=0x2" a.wav

Where "a.wav" is the name of the .WAV file.

Cheers
James




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
