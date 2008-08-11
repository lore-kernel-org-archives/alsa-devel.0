From: "Amaury De Ganseman" <amaury.deganseman@gmail.com>
Subject: clicking/noise when upsampling with ESI juli@
Date: Mon, 11 Aug 2008 12:12:03 +0200
Message-ID: <7fddb68d0808110312i44584d68pc19519fe56efe020@mail.gmail.com>
References: <7fddb68d0808100822q6acec41eqddadfa1bcae33226@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-bounces@lists.sourceforge.net>
In-Reply-To: <7fddb68d0808100822q6acec41eqddadfa1bcae33226@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=alsa-user>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-user-bounces@lists.sourceforge.net
Errors-To: alsa-user-bounces@lists.sourceforge.net
To: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

There's a problem, when I start to play a file the sound is bad
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

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
