From: youling257 <youling257@gmail.com>
Subject: Re: [PATCH v2 01/13] conf/ucm: bytcr-rt5645: Use the
	generic bytcr/PlatformEnableSeq.conf
Date: Sun, 25 Nov 2018 19:11:29 +0800
Message-ID: <20181125111129.8007-1-youling257@gmail.com>
References: <20180808090543.15181-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by alsa0.perex.cz (Postfix) with ESMTP id A7A8226784E
 for <alsa-devel@alsa-project.org>; Sun, 25 Nov 2018 12:11:26 +0100 (CET)
Received: by mail-pg1-f178.google.com with SMTP id y4so4824499pgc.12
 for <alsa-devel@alsa-project.org>; Sun, 25 Nov 2018 03:11:26 -0800 (PST)
In-Reply-To: <20180808090543.15181-1-hdegoede@redhat.com>
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
Cc: tiwai@suse.de, hdegoede@redhat.com, pierre-louis.bossart@linux.intel.com
List-Id: alsa-devel@alsa-project.org

alsaucm -c chtrt5645 set _verb HiFi set _enadev Speaker

ALSA lib conf.c:823:(get_char_skip_comments) Cannot access file
bytcr/PlatformEnableSeq.conf
ALSA lib conf.c:1877:(snd_config_load1) _toplevel_:17:18:Unexpected char

ALSA lib utils.c:67:(uc_mgr_config_load) could not open configuration file
/usr/share/alsa/ucm/ASUSTeKCOMPUTERINC.-X205TA-1.0-X205TA/ASUSTeKCOMPUTERINC.-X205TA-1.0-X205TA.conf
ALSA lib parser.c:1427:(load_master_config) error: could not parse
configuration for card ASUSTeKCOMPUTERINC.-X205TA-1.0-X205TA
ALSA lib conf.c:823:(get_char_skip_comments) Cannot access file
bytcr/PlatformEnableSeq.conf
ALSA lib conf.c:1877:(snd_config_load1) _toplevel_:17:18:Unexpected char
ALSA lib utils.c:75:(uc_mgr_config_load) could not load configuration file
/usr/share/alsa/ucm/chtrt5645/HiFi.conf
ALSA lib parser.c:1101:(parse_verb_file) error: failed to open verb file
/usr/share/alsa/ucm/chtrt5645/HiFi.conf : -2
ALSA lib main.c:946:(snd_use_case_mgr_open) error: failed to import
chtrt5645 use case configuration -22
alsaucm: error failed to open sound card chtrt5645: Invalid argument
