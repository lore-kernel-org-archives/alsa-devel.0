From: "=?gb2312?B?usLLtA==?=" <haoshun@amoi.com.cn>
Subject: (no subject)
Date: Thu, 3 Apr 2008 16:47:07 +0800
Message-ID: <200804031647067658401@amoi.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from amoi.com.cn (unknown [202.101.103.189])
	by alsa0.perex.cz (Postfix) with SMTP id 269B310382B
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Apr 2008 10:40:23 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi:
      I'm confused by a problem when i modify a test application "alsa-lib-1.0.13/test/control.c".
      I wanna use the structure "snd_ctl_elem_value_t",but when i write like this:
             snd_ctl_elem_value_t aaa;
      there will be an error:
             storage size of 'aaa' isn't known
     while 
             snd_ctl_elem_value_t *aaa;
     makes no errors. But i can't change it directly such as:
             aaa->id=test_id ; //test_id is defined before
     cause it will bring an error:
             dereferencing pointer to incomplete type
     I think i should use the function like "snd_ctl_elem_info_set_id",but i just want to know why,i don't think it disobeys the C syntax.Is there something different in the ALSA making procedure?or Makefile?



haoshun
2008-04-03
