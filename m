From: Christian Esken <c.esken@cityweb.de>
Subject: Bug in alsa-lib (Was: alsa-lib: Error code 1 from snd_mixer_selem_set_capture_switch_all() )
Date: Sat, 15 Nov 2003 11:24:10 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311151124.10473.c.esken@cityweb.de>
References: <200311121303.42282.c.esken@cityweb.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200311121303.42282.c.esken@cityweb.de>
Content-Disposition: inline
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

On Wednesday 12 November 2003 13:03, Christian Esken wrote:
> Hello,
>
> I have a problem with snd_mixer_selem_set_capture_switch_all() from
> alsa-lib. The documentation states:
>
> /**
>  * \brief Set value of capture switch control for all channels of a mixer
> simple element
>  * \param elem Mixer simple element handle
>  * \param value control value
>  * \return 0 on success otherwise a negative error code
>  */
> int snd_mixer_selem_set_capture_switch_all(snd_mixer_elem_t *elem, int
> value)
>
> So I should receive either 0 or a negative value. But I receive a return
> value of 1. Does anybody know what this means?!? Any help is appreciated
> greatly.

I have investigated and found a possible bug in alsa-lib.
The documentation of snd_mixer_selem_set_capture_switch_all() only mentions 
return codes 0 and <0. As I said 1 is returned in my case - I now found a 
place where this could happen in the alsa-lib source code. The code is from 
src/mixer/simple.c , revision .59.

snd_mixer_selem_set_capture_switch_all() calls selem_write, which calls 
selem_read(). At the end of selem_read(), you find the following code 
snippet:


        if (memcmp(pvol, s->str[PLAY].vol, sizeof(pvol)) ||
            psw != s->str[PLAY].sw ||
            memcmp(cvol, s->str[CAPT].vol, sizeof(cvol)) ||
            csw != s->str[CAPT].sw)
                return 1;


This is where 1 is returned. But I do not understand the code. Can anybody 
explain to me. It looks a bit like I am passing "bad" parameters, but then I 
would expect to be returned an error code like EINVAL.



Greetings,
           Chris


-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
