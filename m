From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: Re: problem with versioned symbols and shared libraries
Date: Sat, 17 Jan 2004 15:39:38 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <opr1xccczhq1sf88@mail.broadpark.no>
References: <20040116.200200.971177181.rene.rebe@gmx.net> <Pine.LNX.4.58.0401171211090.1879@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0401171211090.1879@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>, Rene Rebe <rene.rebe@gmx.net>
Cc: alsa-devel@lists.sourceforge.net, ziegler@informatik.hu-berlin.de
List-Id: alsa-devel@alsa-project.org

Ah, thanks. That did the trick indeed.

Arve Knudsen

On Sat, 17 Jan 2004 12:18:07 +0100 (CET), Jaroslav Kysela <perex@suse.cz>=
=20
wrote:

> On Fri, 16 Jan 2004, Rene Rebe wrote:
>
>> Let's link a normal object and a shared obeject of the ALSAHelper:
>>
>> rene@idefix:~/develop/trunk/lowlevel/src$ g++ -g -Wall -I. -I../includ=
e
>> -I../../dam/include -I../../utility/include -c -o ALSAHelper.o
>> ALSAHelper.cc
>
>> rene@idefix:~/develop/trunk/lowlevel/src$ g++ --shared -g -Wall -I.
>> -I../include -I../../dam/include -I../../utility/include -o
>> ALSAHelper.so ALSAHelper.cc
>
> I tried that and it seems that you MUST link also this shared module
> against the asound library:
>
> g++ --shared -g -Wall -I. -I../include -I../../dam/include
> -I../../utility/include -lasound -o ALSAHelper.so ALSAHelper.cc
>                         ^^^^^^^^
>
> Otherwise the versioned symbol are not applied. Here is the correct nm
> output:
>
> perex@pnote:~/src/1/svn.rocklinux-consulting.de/gsmp/trunk/lowlevel/src=
>
> nm ALSAHelper.so  | grep snd_pcm_hw_params_get_channels_max
>          U snd_pcm_hw_params_get_channels_max@@ALSA_0.9.0rc4
>
> 					Have fun,
> 						Jaroslav
>
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs
>
>
> -------------------------------------------------------
> The SF.Net email is sponsored by EclipseCon 2004
> Premiere Conference on Open Tools Development and Integration
> See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> http://www.eclipsecon.org/osdn
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
