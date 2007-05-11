From: Nicholas Smethurst <nick.smethurst@gmail.com>
Subject: Getting a full device list (was: alsa-lib functions
 reporting conflicting information with two sound cards)
Date: Fri, 11 May 2007 12:28:43 +0200
Message-ID: <4644455B.4080706@gmail.com>
References: <560009e30704190730q1047b43fh37f5df5fef9ec51f@mail.gmail.com>	
	<75b66ecd0704190846g4036b493q8d7c2bec8cdc08b2@mail.gmail.com>	
	<4627B015.7030401@gmail.com>
	<75b66ecd0704191145u3414a5e6id9e3f10ef9c6b854@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.225])
	by alsa0.perex.cz (Postfix) with ESMTP id 8367F24477
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2007 12:28:49 +0200 (CEST)
Received: by wr-out-0506.google.com with SMTP id 58so854075wri
	for <alsa-devel@alsa-project.org>; Fri, 11 May 2007 03:28:48 -0700 (PDT)
In-Reply-To: <75b66ecd0704191145u3414a5e6id9e3f10ef9c6b854@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi wrote:
> At Thu, 19 Apr 2007 20:08:21 +0200,
> Nicholas Smethurst wrote:
>> However, I note that snd_device_name_hint() does not return hw, plughw,
>> plug, dmix, etc. Are these obtained elsewhere? I would like to build a
>> complete list of all available devices in order to allow the user to
>> select them from a dropdown list in a GUI.
>
> They are not shown unless you give the device description explicitly
> or set a global flag.  See the description of snd_device_name_hint()
> function.

Well I tried to understand how to do the two things you mention, but am
still stuck..

In namehint.c, I note that the snd_device_name_hint() function has the
following code:

    if (strcmp(iface, "card") == 0)
        list.iface = SND_CTL_ELEM_IFACE_CARD;
    else if (strcmp(iface, "pcm") == 0)
        list.iface = SND_CTL_ELEM_IFACE_PCM;
    else if (strcmp(iface, "rawmidi") == 0)
        list.iface = SND_CTL_ELEM_IFACE_RAWMIDI;
    else if (strcmp(iface, "timer") == 0)
        list.iface = SND_CTL_ELEM_IFACE_TIMER;
    else if (strcmp(iface, "seq") == 0)
        list.iface = SND_CTL_ELEM_IFACE_SEQUENCER;
    else if (strcmp(iface, "hwdep") == 0)
        list.iface = SND_CTL_ELEM_IFACE_HWDEP;
    else
        return -EINVAL;

which thus gives possible interface strings of "card", "pcm", "rawmidi",
"timer", "seq", and "hwdep". I concluded from this that the only way to
get the default devices is to set the global variable.

I thus tried doing the following in a small test app:

    snd_config_t * conf;
    int show_all;
    snd_config_update();
    if (snd_config_search(snd_config, "defaults.namehint.showall",
&conf) >= 0) {
        show_all = snd_config_get_bool(conf);
        if (show_all < 1) {
            snd_config_set_integer(conf, 1);
        }
    } else { // Create node.
        ...
    }

but this doesn't work.. I am apparently doing something wrong since the
global configuration is not changed with my code.

Is it possible to change global variables from a user application? Or is
it currently necessary to manually edit the alsa.conf file (as root) in
order to modify "defaults.namehint.showall" to allow applications to see
all devices?

I wish to obtain a full list of available devices in a user application
without running as root and without insisting that the user manually
edits configuration files that he doesn't understand.

Is this possible? If not, can we work towards implementing such
functionality?

Nicholas
