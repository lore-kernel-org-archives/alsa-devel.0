From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: AC3 output problem with via82xx
Date: Thu, 04 Sep 2003 19:17:01 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F57819D.9040703@superbug.demon.co.uk>
References: <200309041932.05033.jareguero@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200309041932.05033.jareguero@telefonica.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jose Alberto Reguero <jareguero@telefonica.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jose Alberto Reguero wrote:
> I have a problem with ogle 0.9.1 and alsa 0.9.6 with AC3 output.
> My Sound card is VIA 8235 whith AC97 CODEC Realtek ALC650.
>                       
> ERROR[ogle_audio]: Unable to update the IEC958 control: No such file or 
> directory                                                                               
> 
> Thanks.
> 
> Jose Alberto Reguero.
> 
> 
You will not get AC3 passthru output, because support for teh ALC650 
SPDIF has only just finished. The code is in CVS, but not released yet.

Cheers
James




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
