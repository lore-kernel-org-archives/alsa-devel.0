From: Raymond <rayau@netvigator.com>
Subject: Re: problems with snd_au8830 module under mandriva 2005
Date: Wed, 14 Sep 2005 12:42:11 +0800
Message-ID: <4327AA23.5040501@netvigator.com>
References: <4317CC51.3040709@netvigator.com>	 <200509042134.23916.alien999999999@users.sourceforge.net>	 <1126131309.17399.8.camel@pc-erik.lan>	 <44272.62.59.249.250.1126163238.squirrel@62.59.249.250> <1126668747.6835.11.camel@pc-erik.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1126668747.6835.11.camel@pc-erik.lan>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Erik <assie2@zonnet.nl>
Cc: openvortex-dev@nongnu.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Erik wrote:
> yup i have the first problem   
>  1. the ones where if you get 49% it's loud and on 51% quite silently? 
> 
> but then from 51 to 100% is again soft to loud .
> 
> next week i can find time to recompile the whole kernel
> 
> erik

It seem that MX300 has different device id

1092:3000	Monster Sound II
1092:3001	Monster Sound II
1092:3002	Monster Sound II
1092:3003	Monster Sound II
1092:3004	Monster Sound II

http://pci-ids.ucw.cz/iii/?i=12eb0002

Please provide the output of

cat /proc/asound/au8830/codec97#0/ac97#0-0+regs

and

lspci -vvn


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
