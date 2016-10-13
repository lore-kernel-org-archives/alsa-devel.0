From: Christian N <cnegris01@gmail.com>
Subject: struct snd_soc_codec_driver nested and duplicated
	fields
Date: Thu, 13 Oct 2016 11:06:14 -0300
Message-ID: <CAPNHxoH1kFGwXhPhDTg5s1Y4mbJFsPbjkjR7RT+Aq7AvmFdWnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f178.google.com (mail-yw0-f178.google.com
 [209.85.161.178])
 by alsa0.perex.cz (Postfix) with ESMTP id 25DF0266DB4
 for <alsa-devel@alsa-project.org>; Thu, 13 Oct 2016 16:06:16 +0200 (CEST)
Received: by mail-yw0-f178.google.com with SMTP id w3so53983383ywg.1
 for <alsa-devel@alsa-project.org>; Thu, 13 Oct 2016 07:06:16 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi

I'm tryng to understand serveral links between asoc structures to
avoid bad codec/machine driver implementation (TEF663x for iMX6).

I saw that several structures have pointer to structures which one
could have pointer to the first one, and serveral fields are
duplicated.

Some examples

snd_soc_codec_driver->probe
snd_soc_codec_driver->snd_soc_dapm_widget

but

snd_soc_codec_driver->snd_soc_component_driver->probe (duplicated?)
snd_soc_codec_driver->snd_soc_component_driver->snd_soc_dapm_widget
(duplicated?)

and
 snd_soc_codec_driver->snd_soc_component_driver->snd_soc_dapm_widget->snd_soc_dapm_context->
snd_soc_component (hey is recursive???!!!!!)

I would like figure out why several fields are duplicated in
structures that could be nested.
Is a compatibility issue?

thanks in advance
