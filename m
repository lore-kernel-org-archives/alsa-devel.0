From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: Flash 9
Date: Thu, 26 Oct 2006 02:03:34 +0100
Message-ID: <yw1xlkn3yjkp.fsf@agrajag.inprovide.com>
References: <1161720441.3982.124.camel@mindpipe>
	<453E87BD.8020900@hennerich.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Juergen Hennerich <juergen@hennerich.eu> writes:

> Lee Revell schrieb:
>> Is it legal for a proprietary application to incorporate alsa-lib by
>> static linking?  I thought this required an LGPL exception.
>> =

> They'd have to provide the object files and a linker script to relink =

> the lib.
>
>> Because contrary to what Adobe says, this is what the new Flash 9 beta
>> does:
>> =

>> $ ldd .mozilla/plugins/libflashplayer.so | grep asound =

>> $
>> =

>> $ strings .mozilla/plugins/libflashplayer.so | grep snd_
>> snd_pcm_open
>> snd_pcm_close
>> snd_pcm_start
>> snd_pcm_drop
>> snd_pcm_prepare
>> snd_pcm_resume
>> snd_pcm_hw_params_sizeof
>> snd_pcm_sw_params_sizeof
>> snd_pcm_status_sizeof
>> snd_pcm_info
>> snd_pcm_info_get_id
>> snd_pcm_info_get_name
>> snd_pcm_hw_params_any
>> snd_pcm_hw_params_set_access
>> snd_pcm_hw_params_set_format
>> snd_pcm_hw_params
>> snd_pcm_sw_params_current
>> snd_pcm_sw_params
>> =

>> Etc.
>> =

>> Lee
>> =

> Because you find those strings in the library, doesn't necessarily mean, =

> that there is code from libasound in this library.
>
> -> man dlopen

Flash player does use dlopen() so everything is fine.

-- =

M=E5ns Rullg=E5rd
mru@inprovide.com


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
