From: Yannick Beynet <beynet@fresnes.info>
Subject: Re: alsa 0.9.4 and gcc 3.3
Date: Tue, 24 Jun 2003 21:24:43 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EF8A57B.4060703@fresnes.info>
References: <3EF70464.1070004@fresnes.info> <s5hllvrx0py.wl@alsa2.suse.de> <3EF89E8E.3010000@fresnes.info>
Reply-To: beynet@fresnes.info
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3EF89E8E.3010000@fresnes.info>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Yannick Beynet a e'crit :

> Takashi Iwai a e'crit :
>
>>At Mon, 23 Jun 2003 15:45:08 +0200,
>>Yannick Beynet wrote:
>>  
>>
>>>Hi !
>>>I have a problem with configure script
>>>My kernel has been made with gcc 3.3, alsa 's configure find that gcc 
>>>version is 3.3 but it prints that compilers mismatch ... My kernel 
>>>version is 2.4.21
>>>Any Idea ? (It works with alsa 0.9.2 but not with alsa 0.9.4)
>>>    
>>>
>>
>>this should have been fixed on cvs.
>>could you try it?
>>
>>if it doesn't work, please report the exact messages that configure
>>script told you.
>>
>>
>> 
>>
>>
>>-------------------------------------------------------
>>This SF.Net email is sponsored by: INetU
>>Attention Web Developers & Consultants: Become An INetU Hosting Partner.
>>Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
>>INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
>>_______________________________________________
>>Alsa-devel mailing list
>>Alsa-devel@lists.sourceforge.net
>>https://lists.sourceforge.net/lists/listinfo/alsa-devel
>>
>>  
>>
> well, now configure script works with cvs sources !
> Thanks Takashi !!
> ------------------------------------------------------- This SF.Net 
> email is sponsored by: INetU Attention Web Developers & Consultants: 
> Become An INetU Hosting Partner. Refer Dedicated Servers. We Manage 
> Them. You Get 10% Monthly Commission! INetU Dedicated Managed Hosting 
> http://www.inetu.net/partner/index.php 
> _______________________________________________ Alsa-devel mailing 
> list Alsa-devel@lists.sourceforge.net 
> https://lists.sourceforge.net/lists/listinfo/alsa-devel 

sorry, I said something wrong, I got the same problem
message is :

checking for kernel version... 2.4.21
checking for GCC version... Kernel compiler: version gcc 3.3 (Debian) 
Used compiler: gcc (GCC) 3.3 (Debian)
Fatal error: Compiler type does not match
Decoded kernel compiler: type=version version=gcc
Decoded used compiler: type=gcc version=3.3

perhaps just a problem with my debian, I 'll try to investigate ...



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
