From: Yannick Beynet <beynet@fresnes.info>
Subject: Re: alsa 0.9.4 and gcc 3.3
Date: Sun, 29 Jun 2003 17:28:38 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EFF05A6.5060005@fresnes.info>
References: <3EF70464.1070004@fresnes.info> <s5hllvrx0py.wl@alsa2.suse.de> <3EF89E8E.3010000@fresnes.info> <3EF8A57B.4060703@fresnes.info>
Reply-To: beynet@fresnes.info
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3EF8A57B.4060703@fresnes.info>
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

Yannick Beynet a =E9crit :

> Yannick Beynet a e'crit :
>
>> Takashi Iwai a e'crit :
>>
>>> At Mon, 23 Jun 2003 15:45:08 +0200,
>>> Yannick Beynet wrote:
>>> =20
>>>
>>>> Hi !
>>>> I have a problem with configure script
>>>> My kernel has been made with gcc 3.3, alsa 's configure find that=20
>>>> gcc version is 3.3 but it prints that compilers mismatch ... My=20
>>>> kernel version is 2.4.21
>>>> Any Idea ? (It works with alsa 0.9.2 but not with alsa 0.9.4)
>>>>  =20
>>>
>>>
>>> this should have been fixed on cvs.
>>> could you try it?
>>>
>>> if it doesn't work, please report the exact messages that configure
>>> script told you.
>>>
>>>
>>>
>>>
>>>
>>> -------------------------------------------------------
>>> This SF.Net email is sponsored by: INetU
>>> Attention Web Developers & Consultants: Become An INetU Hosting=20
>>> Partner.
>>> Refer Dedicated Servers. We Manage Them. You Get 10% Monthly=20
>>> Commission!
>>> INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.ph=
p
>>> _______________________________________________
>>> Alsa-devel mailing list
>>> Alsa-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>>>
>>> =20
>>>
>> well, now configure script works with cvs sources !
>> Thanks Takashi !!
>> ------------------------------------------------------- This SF.Net=20
>> email is sponsored by: INetU Attention Web Developers & Consultants:=20
>> Become An INetU Hosting Partner. Refer Dedicated Servers. We Manage=20
>> Them. You Get 10% Monthly Commission! INetU Dedicated Managed Hosting=20
>> http://www.inetu.net/partner/index.php=20
>> _______________________________________________ Alsa-devel mailing=20
>> list Alsa-devel@lists.sourceforge.net=20
>> https://lists.sourceforge.net/lists/listinfo/alsa-devel=20
>
>
> sorry, I said something wrong, I got the same problem
> message is :
>
> checking for kernel version... 2.4.21
> checking for GCC version... Kernel compiler: version gcc 3.3 (Debian)=20
> Used compiler: gcc (GCC) 3.3 (Debian)
> Fatal error: Compiler type does not match
> Decoded kernel compiler: type=3Dversion version=3Dgcc
> Decoded used compiler: type=3Dgcc version=3D3.3
>
> perhaps just a problem with my debian, I 'll try to investigate ...
>
well I found the problem
to find gcc version, configure script uses gcc --version witch answer :=20
"gcc (GCC) 3.3 (Debian)"
or in kernel_dir/include/linux/compil.h I found #define LINUX_COMPILER=20
"version gcc 3.3 (Debian)" witch is the result of gcc -v
Is it a problem specific of my debian and gcc 3.3 ?



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
