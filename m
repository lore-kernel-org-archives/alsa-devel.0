From: Tobias Peters <tpeters@uni-oldenburg.de>
Subject: Re: hw_pointer error message triggered without need
Date: Wed, 22 Oct 2003 10:25:49 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F963F0D.70205@uni-oldenburg.de>
References: <3F9552BA.1020404@uni-oldenburg.de>	 <s5hd6cqcyry.wl@alsa2.suse.de>	 <Pine.LNX.4.53.0310211910520.1483@pnote.perex-int.cz>	 <s5h8ynecw5s.wl@alsa2.suse.de> <1066788033.2882.40.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1066788033.2882.40.camel@localhost>
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

Manuel Jander wrote:
> There really something wrong. 
> ALSA sound/core/pcm_lib.c:157: Unexpected hw_pointer value (stream = 0,
> delta: -297, max jitter = 1024): wrong interrupt acknowledge?

>>>>At Tue, 21 Oct 2003 17:37:30 +0200,
>>>>Tobias Peters wrote:
>>>>>ALSA ../alsa-kernel/core/pcm_lib.c:216: Unexpected hw_pointer value
>>>>>(stream = 0, delta: -255, max jitter = 256): wrong interrupt acknowledge?

Compare the line numbers, yours is a different error message.

The minus sign in the message I got is just fine, because the new 
hw_pointer value really is lesser than it was before.

   Tobias




-------------------------------------------------------
This SF.net email is sponsored by OSDN developer relations
Here's your chance to show off your extensive product knowledge
We want to know what you know. Tell us and you have a chance to win $100
http://www.zoomerang.com/survey.zgi?HRPT1X3RYQNC5V4MLNSV3E54
