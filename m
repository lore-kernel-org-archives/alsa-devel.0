From: =?ISO-8859-1?Q?Peter_Lund=E9n?= <plu@tii.se>
Subject: Re: HDSP 96/52
Date: Tue, 29 Apr 2003 09:00:28 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EAE230C.7050509@tii.se>
References: <20030427080603.GB641@always.joy.eth.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Joshua N Pritikin <vishnu@pobox.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I have a HDSP with multiface on my laptop. I know this is not exactly 
the same but I think the drivers share alot of code. I have experience 
problems with the matrix mixer. It does not seam to be stable, after 
rebooting it works sometime and sometimes not. I have not been able to 
figure out any pattern in the behavior yet.

--PLu

Joshua N Pritikin wrote:

>Mark Knecht wrote:
>  
>
>>I'm getting a lot of reasonable or even good results, but no actual
>>audio unfortunately.
>>    
>>
>
>Me too.  The driver loads fine.  hdspconf works great.  My A/D
>converter is happy.  i tried running the following script to
>set all the mixer levels to unity.
>
>for dest in $(seq 0 26);do
>  for i in $(seq 0 51);do
>    amixer cset numid=5 $i,$dest 32768 > /dev/null;
>  done
>done
>
>However, i've never gotten any audio through the card.  Only silence.
>If there is any patch available then i'm happy to test it.
>
>  
>





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
