From: Weijia Yang <gte733z@prism.gatech.edu>
Subject: Re: cs46xx experimental DSP drivers
Date: Tue, 24 Sep 2002 21:45:52 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D911550.1000309@prism.gatech.edu>
References: <3D8F7F59.6030105@prism.gatech.edu> <3D90A8D8.7070103@cucumelo.org> <3D90B54F.20402@prism.gatech.edu> <3D90D641.7050200@cucumelo.org> <3D90FEF4.2040309@prism.gatech.edu> <20020925010013.GC990@porky>
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
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Peter Heatwole <peter599@gotnet.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> 
>    You probably just stuck a define in cs46xx_lib.c.  Append the 
> following into alsa-driver/pci/cs46xx/Makefile, to the end of the
> EXTRA_FLAGS line:
> 
> -DCONFIG_SND_CS46XX_DEBUG_GPIO=1
> 
> 
> HTH,
> -- Peter Heatwole
> "Murphy was just a well known pessimist."
> 
> 

Thanks for the tip--everything compiles fine now.  Now, how exactly do I 
go about testing these EGPIO settings? I see several EGPIO options in 
alsamixer--do I just adjust these and find something that works? Thanks


-- 
Weijia Yang
School of Electrical and Computer Engineering
Georgia Institute of Technology
Atlanta, GA



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
