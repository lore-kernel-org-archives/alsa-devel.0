From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: [Fwd: Re: [PATCH] cs46xx DAC volume's mechanism
 rewrite, minor bugfixes]
Date: Mon, 11 Nov 2002 09:56:29 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DCF70BD.3020603@cucumelo.org>
References: <1036972438.4956.0.camel@pete>
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
To: Peter Good <psgood@petesinternet.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>
>------------------------------------------------------------------------
>
>Ok, that's fixed the bass problem I had here.
>One thing though. Benny, do you have any idea what these values "should"
>be?
>  
>
But I still dont understand the problem. And reports are not at all 
consequent ...

>iec958:AES0=0x6,AES1=0x82,AES2=0x0,AES3=0x2
>  
>
I guess you need to add in .asoundrc:
iec958 {
  type hw
  card 0
  device 2
}

Then maybe someone knows what xine uses the 
AES0=0x6,AES1=0x82,AES2=0x0,AES3=0x2 values to,
do they need to interfaces to the lowlevel driver ???

/Benny




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
