From: Hinko Kocevar <hinko.kocevar@cetrtapot.si>
Subject: Re: Using headphones
Date: Wed, 10 Aug 2005 20:40:10 +0200
Message-ID: <42FA4A0A.6060705@cetrtapot.si>
References: <6A09F73E2878E447BF6B87C43162C827021545A7@excwa1b2.sharpsec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <6A09F73E2878E447BF6B87C43162C827021545A7@excwa1b2.sharpsec.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Nambiar, Anil" <NambiarA@sharpsec.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Nambiar, Anil wrote:
> Hi,
> 
>             I have got alsa driver and aplay up and running on my arm 
> based board. Now the AC97 codec on the board is using headphone out 
> instead of speaker out. But the ac97 library in alsa is muting 
> headphones and using speaker and phone. I can unmute headphone in the 

I'm seeing the same issue here - PXA255 and UCB1400 AC'97 codec. I just need to 
add one-line-hack to enable headphone output as well. It would be nice to avoid 
this and use userspace to enable headphones, but it is not a major issue for me 
though.


-- 
..because under Linux "if something is possible in principle,
then it is already implemented or somebody is working on it".

					--LKI


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
