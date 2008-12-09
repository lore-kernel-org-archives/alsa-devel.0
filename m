From: David Dillow <dave@thedillows.org>
Subject: Re: question on hardware mixing
Date: Tue, 09 Dec 2008 07:44:25 -0500
Message-ID: <1228826665.6119.17.camel@obelisk.thedillows.org>
References: <20081205165341.GA21294@rakim.wolfsonmicro.main>
	<1228496062-21379-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<98769532B4BB14429434178695419EAE26861315@bgsmsx501.gar.corp.intel.com>
	<75b66ecd0812052058r36ed20fdo3dc6e40ac23339bf@mail.gmail.com>
	<98769532B4BB14429434178695419EAE268614A1@bgsmsx501.gar.corp.intel.com>
	<493E31E3.2080504@ladisch.de>
	<98769532B4BB14429434178695419EAE268E0FA6@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.knology.net (smtp.knology.net [24.214.63.101])
	by alsa0.perex.cz (Postfix) with ESMTP id 43E8A1037F4
	for <alsa-devel@alsa-project.org>; Tue,  9 Dec 2008 13:44:29 +0100 (CET)
In-Reply-To: <98769532B4BB14429434178695419EAE268E0FA6@bgsmsx501.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Harsha, Priya" <priya.harsha@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lee Revell <rlrevell@joe-job.com>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Tue, 2008-12-09 at 14:25 +0530, Harsha, Priya wrote:
> If I define mixer controls to switch between each substream, I would
> not be able to handle multiple streams at time....

Check into the ALSA configuration file syntax -- there are number of
things you can do there, like define a 'voice' device that uses hooks to
set a control setting (snd_kcontrol) when you open a PCM. You can use
that control setting to let your driver know if the PCM channel is being
used for voice or audio traffic.

Look at how the EMU10K1 handles surround sound audio
in /etc/alsa/cards/EMU10K1.conf

I started to do some similar things for sis7019 surround sound, but
they've never made it out of my office due to lack of time/testing HW.

> I had asked this in my earlier follow up email as well - can I use
> snd_pcm_t->private_data to communicate if it's a voice or audio 
> I understand this private_data gets copied to substream->private data
> which will reach the driver...
> Am I right here?

I can't answer this specifically, but I believe the answer is in the
name -- 'private'. This is for the ALSA system to use, you can hang your
own data off a substream using snd_pcm_substream_chip(). Besides, how do
you plan on setting it in the snd_pcm_t type?

I think that if you set up some controls, use the config file language,
and have your audio apps open a 'voice' device, you can get where you
want. 

Dave
