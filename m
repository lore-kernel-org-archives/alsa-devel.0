From: "Amaury De Ganseman" <amaury.deganseman@gmail.com>
Subject: clicking/noise when upsampling with ESI juli@
Date: Sun, 10 Aug 2008 17:38:32 +0200
Message-ID: <7fddb68d0808100838m7c67132cr72304f54478da18e@mail.gmail.com>
References: <7fddb68d0808100822q6acec41eqddadfa1bcae33226@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ik-out-1112.google.com (ik-out-1112.google.com [66.249.90.178])
	by alsa0.perex.cz (Postfix) with ESMTP id 25CDD24402
	for <alsa-devel@alsa-project.org>;
	Sun, 10 Aug 2008 17:38:33 +0200 (CEST)
Received: by ik-out-1112.google.com with SMTP id b32so1811419ika.0
	for <alsa-devel@alsa-project.org>; Sun, 10 Aug 2008 08:38:32 -0700 (PDT)
In-Reply-To: <7fddb68d0808100822q6acec41eqddadfa1bcae33226@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

There's a problem when I start to play a file the sound is bad
during 1sec or less (clicking,cracking,...) or when I switch between
tracks I hear clicks.


Any idea ?


Note: It works very well with OSS driver (last mercurial)

Thanks for help.


Here my asoundrc:

defaults.pcm.rate_converter "speexrate_best"




pcm.!default {
  type plug
  slave.pcm {
      type dmix
      ipc_key 1478
      slave {
          pcm "hw:0,1"
          format S32_LE
       #period_time 0
       period_size 2048
       buffer_size 8192
          rate 48000
}

  }
#rate_converter "speexrate_best"
#rate_converter "samplerate_best"
}
