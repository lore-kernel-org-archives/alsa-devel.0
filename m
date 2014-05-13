From: Eduard Gilmutdinov <edgilmutdinov@gmail.com>
Subject: [RFC PATCH 0/2] Add support for audio cards with
	multiple endpoints on the one interface
Date: Tue, 13 May 2014 10:08:49 +0600
Message-ID: <1399954131-26516-1-git-send-email-edgilmutdinov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f53.google.com (mail-la0-f53.google.com
 [209.85.215.53])
 by alsa0.perex.cz (Postfix) with ESMTP id A1E532652E3
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 06:09:09 +0200 (CEST)
Received: by mail-la0-f53.google.com with SMTP id ec20so2554276lab.40
 for <alsa-devel@alsa-project.org>; Mon, 12 May 2014 21:09:09 -0700 (PDT)
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
Cc: mark@xwax.org, daniel@zonque.org
List-Id: alsa-devel@alsa-project.org

Devices of company Focusrite (Novation) contain multiple endpoints on a single interface. In particular (1235:0010) "Novation Saffire 6 USB" on one interface have endpoints for playback and capture. Functions "set_format" and "pcm_close" are generated when new stream is creating and when it is closing respectively. They contain a function call "usb_set_interface" which resets interface and endpoints on it. Thus it is imposible to capture and playback a sound at the same time. To avoid this, suggest to monitor the status of the interface and endpoint on it. Status of endpoints can be monitored by the field "enabled" of the structure "usb_host_endpoint". This approach should not affect for the audio cards with one endpoint on the interface.

Please correct me if I'm wrong.
