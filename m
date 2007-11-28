From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Pls don't require exclusive Alsa audio
 device access, use snd_pcm_dmix_open ()
Date: Wed, 28 Nov 2007 11:36:55 +0000
Message-ID: <fijjso$aeg$1@ger.gmane.org>
References: <471FE2A7.9080309@googlemail.com>
	<47201223.5050304@googlemail.com>	<474D2F8A.9090001@googlemail.com>
	<Pine.LNX.4.61.0711281014180.8244@tm8103.perex-int.cz>
Reply-To: Ekiga development mailing list <ekiga-devel-list@gnome.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ekiga-devel-list-bounces@gnome.org>
In-Reply-To: <Pine.LNX.4.61.0711281014180.8244@tm8103.perex-int.cz>
List-Unsubscribe: <http://mail.gnome.org/mailman/listinfo/ekiga-devel-list>,
	<mailto:ekiga-devel-list-request@gnome.org?subject=unsubscribe>
List-Archive: </archives/ekiga-devel-list>
List-Post: <mailto:ekiga-devel-list@gnome.org>
List-Help: <mailto:ekiga-devel-list-request@gnome.org?subject=help>
List-Subscribe: <http://mail.gnome.org/mailman/listinfo/ekiga-devel-list>,
	<mailto:ekiga-devel-list-request@gnome.org?subject=subscribe>
Sender: ekiga-devel-list-bounces@gnome.org
Errors-To: ekiga-devel-list-bounces@gnome.org
To: ekiga-devel-list@gnome.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Wed, 28 Nov 2007, thomas schorpp wrote:
> 
>>> +    if (_snd_pcm_dmix_open (&os_handle, real_device_name, snd_config_t* 
>>> root, snd_config_t* sconf, stream, SND_PCM_NONBLOCK) < 0) {
> 
> Uff. It's really wrong. What you're trying to do? Simply use 'default' 
> device name for snd_pcm_open() which should have defined dmix access if 
> required. And don't forget to allow specify (force) ALSA device name to 
> users if someone wants a special setup.

+1 Dmix should not be enforced... this can be handled at a lower
level.... e.g. with dmix configured in alsa config or by using
pulseaudio instead of dmix (my preferred solution so I can switch from
my internal speakers to my usb headset should I plug it in mid-call).

Col.
