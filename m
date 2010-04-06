From: Pradeep Kumar Jilagam <pradeep.jilagam@gmail.com>
Subject: Re: Help! Need to switch between normal speaker and BT
	headset dynamically
Date: Tue, 6 Apr 2010 10:36:49 +0530
Message-ID: <s2kc731536d1004052206t279dd76au1804bd0d8339cec8@mail.gmail.com>
References: <x2vc731536d1004040850gedb4eee1rccf18941cf25aade@mail.gmail.com>
	<s2u604760771004041236k317d9430vf0ea551f17c6374e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by alsa0.perex.cz (Postfix) with ESMTP id 5A3DB24346
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Apr 2010 07:06:50 +0200 (CEST)
Received: by pvg12 with SMTP id 12so2005199pvg.38
	for <alsa-devel@alsa-project.org>; Mon, 05 Apr 2010 22:06:49 -0700 (PDT)
In-Reply-To: <s2u604760771004041236k317d9430vf0ea551f17c6374e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Chen <seven.steps@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Daniel,

Thanks for your response.

I am trying to get this working on a small embedded system with limited
memory and processing capabilities. I have also explored in the direction of
pulseaudio but I am not sure whether it is small enough to fit into a small
system. Aslo, I I came to know that the default output device will again
have to be manually changed in the GUI menu fo pulseaudio to start streaming
on the BT headset after updating asoundrc with its MAC address.

I am trying to find out whether the streaming can automatically start
routing to the BT headset as soon as it is detected without any need for
user's intervention. I am trying to find out whether it is possible to do so
and also whether there is any plugin/application available for it.

Thanks,
Pradeep
On Mon, Apr 5, 2010 at 1:06 AM, Daniel Chen <seven.steps@gmail.com> wrote:

> On Sun, Apr 4, 2010 at 11:50 AM, Pradeep Kumar Jilagam
> <pradeep.jilagam@gmail.com> wrote:
> > Is this possible to do and if yes, is there an ALSA application/plugin
> > already available for this?
>
> e.g., PulseAudio?
>
