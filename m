From: Kasper Souren <kasper@303.nu>
Subject: Re: 1869 trouble with snd-es18xx
Date: Thu, 27 Jun 2002 16:13:14 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D1B1D7A.4070602@303.nu>
References: <200206271408.g5RE8VD25834@post2.fast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
To: Paul Davis <pbd@op.net>, alsa devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
>>Isn't there any option to use a 'virtual' ALSA device? Like snd-pcm-oss, but 
>>then the other way around. snd-oss-pcm module? Then you could use ALSA with 
>>a working OSS driver, and no working ALSA driver...
> 
> 
> ALSA has a significantly different internal architecture than OSS. It
> is not possible to use an OSS driver to support the ALSA "midlevel"
> code.

What kind of "midlevel" code?

I meant an ALSA driver, that you can assign an OSS device. The "midlevel" 
ALSA stuff can be handled by the ALSA driver, that just sends the audio data 
to the OSS device.

greetz,
Kasper




-------------------------------------------------------
Sponsored by:
ThinkGeek at http://www.ThinkGeek.com/
