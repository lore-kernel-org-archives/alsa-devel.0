From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Am I asking the right people ?
Date: Wed, 27 Nov 2002 18:48:42 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DE478DA.1090209@superbug.demon.co.uk>
References: <Pine.LNX.4.33.0211251302260.517-100000@pnote.perex-int.cz> <3DE2C348.5040805@tele-ip.com> <3DE472FA.1060300@tele-ip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33.0211251302260.517-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Bruce Paterson <bruce@tele-ip.com>
Cc: alsa development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Bruce Paterson wrote:

> Am I sending these queries about the operation of alsa through the API 
> to the right place ? I'm trying to use alsa for a real scientific
> application and I'm starting to worry it simply isn't ready yet.
>
> I don't pretend to be a developer of alsa drivers themselves, and I'd 
> hoped I didn't need to become one. I understand alsa needs many people 
> debugging it and finding problems to make it bulletproof (afterall 
> there would be a myriad of different possible configurations people 
> can use).
>
> However, the silence I get in reply to queries is golden (unlike the
> distortion I'm getting from the soundcard) !
>
> It's possible I'm not using the alsa API in the way intended and 
> bringing the problems upon myself, but please, somebody tell me !
>
> It would be a real blow to the progress of linux in this company if 
> all the alsa work had to be scrapped.
>
> Apologies for the frustrated tone.
>
> Bruce Paterson wrote:
>
>>>>>>> Behaviour:
>>>>>>> The output sound is perfect for about 2 minutes. After that 
>>>>>>> every now and then I get "distortion" in the audio. No xruns or 
>>>>>>> errors are reported in the software. It sounds like only part of 
>>>>>>> the output buffer is correct (the general gist is right, but 
>>>>>>> there's crap and warbles there as well).
>>>>>>
>
You could try using a different linux application, and thus narrow down 
the problem to your app or alsa.
I helped with the xine (xine.sf.net) media player, and it has native 
alsa support, and detects xruns well. You might want to try that.
Alsa also emulates oss, so any application that uses oss can also be 
used to do the test.
It might be that your software is not detecting xruns correctly.
The problems that you are getting, sound to me that you are getting XRUNs.
It might be worth trying your application with a different sound card. 
If that fixes the problem, it might point to a bug in the alsa driver 
for your particular sound card.

Cheers
James




-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
