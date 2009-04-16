From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: SALSA library and recording
Date: Thu, 16 Apr 2009 09:12:17 +0200
Message-ID: <49E6DA51.1020304@ladisch.de>
References: <5b6fae700904150932x5079088m9b2373cee37053b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 957E91037FF
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 09:12:12 +0200 (CEST)
In-Reply-To: <5b6fae700904150932x5079088m9b2373cee37053b6@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manisha Sankpal <manisha.sankpal@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Manisha Sankpal wrote:
> I am using salsa library to capture the data from the sound card.  The
> requirement is that the recording should be done from line-in port of the
> sound card. The selection of "Line-in" port should be done  programatically.
> 
> With ALSA library, I am able to select the line-in by calling
> snd_mixer_selem_set_capture_switch_all()  function. However, this function
> is returning an error when SALSA library is used.

The high-level mixer functions are not implemented in the SALSA library.

> Is there any other function/way to select the line-in mixer element in
> the SALSA API?

You'll have to use the snd_ctl* functions.
To change the value of a mixer control, do something like this:

	snd_ctl_t *ctl;
	snd_ctl_elem_value_t *value;
	int onoff = 1; /* or 0 for off */

	err = snd_ctl_open(&ctl, "default", 0);
	...
	snd_ctl_elem_value_alloca(&value);
	...
	snd_ctl_elem_value_set_interface(value, SND_CTL_ELEM_IFACE_MIXER);
	snd_ctl_elem_value_set_name(value, "xxxxx Capture Switch");
	snd_ctl_elem_value_set_boolean(value, 0, onoff);
	err = snd_ctl_elem_write(ctl, value);
	...
	snd_ctl_close(ctl);

You have to use the correct name; the names of mixer controls can be
seen in the output of "amixer controls".

If your hardware has a single "Capture Source" control instead, you
have to replace _set_boolean with _set_enumerated and use the correct
index.


HTH
Clemens
