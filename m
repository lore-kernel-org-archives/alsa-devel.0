From: Matthias Koenig <mkoenig@suse.de>
Subject: Re: Problems in writing test apps
Date: Thu, 03 Apr 2008 11:59:00 +0200
Message-ID: <n7xmyobi7iz.fsf@sor.suse.de>
References: <200804031659332034329@amoi.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	by alsa0.perex.cz (Postfix) with ESMTP id D94E9243B0
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Apr 2008 11:57:52 +0200 (CEST)
In-Reply-To: <200804031659332034329@amoi.com.cn> (haoshun@amoi.com.cn's
	message of "Thu\, 3 Apr 2008 16\:59\:33 +0800")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: haoshun <haoshun@amoi.com.cn>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

"haoshun" <haoshun@amoi.com.cn> writes:

> Hi:
>       sorry,forget to add the subject right now...
>       I'm confused by a problem when i modify a test application
>       "alsa-lib-1.0.13/test/control.c".  I wanna use the structure
>       "snd_ctl_elem_value_t",but when i write like this:
>              snd_ctl_elem_value_t aaa;
>       there will be an error:
>              storage size of 'aaa' isn't known
>      while 
>              snd_ctl_elem_value_t *aaa;
>      makes no errors. But i can't change it directly such as:
>              aaa->id=test_id ; //test_id is defined before
>      cause it will bring an error:
>              dereferencing pointer to incomplete type
>      I think i should use the function like
>      "snd_ctl_elem_info_set_id",but i just want to know why,i don't
>      think it disobeys the C syntax.Is there something different in
>      the ALSA making procedure?or Makefile?

The ALSA data types are designed to be opaque. You cannot access the 
members of the structures directly as the structure definitions are 
simply not exported on purpose.  You have to use the access functions.
E.g. allocating a snd_ctl_elem_value_t structure will be done with the
int snd_ctl_elem_value_malloc(snd_ctl_elem_value_t **ptr)

Matthias
