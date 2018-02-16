From: Dimitris Papavasiliou <dpapavas@gmail.com>
Subject: Need help implementing an external PCM/control plugin
	pair
Date: Fri, 16 Feb 2018 12:12:43 +0200
Message-ID: <0daf8a5e-c1dd-224e-52e7-7467d93aa045@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f174.google.com (mail-wr0-f174.google.com
 [209.85.128.174])
 by alsa0.perex.cz (Postfix) with ESMTP id A74F2267C4D
 for <alsa-devel@alsa-project.org>; Fri, 16 Feb 2018 11:12:49 +0100 (CET)
Received: by mail-wr0-f174.google.com with SMTP id o76so2332126wrb.7
 for <alsa-devel@alsa-project.org>; Fri, 16 Feb 2018 02:12:49 -0800 (PST)
Received: from [192.168.1.106] (ipa1.211.tellas.gr. [62.169.211.1])
 by smtp.gmail.com with ESMTPSA id b136sm12228831wme.34.2018.02.16.02.12.44
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 16 Feb 2018 02:12:44 -0800 (PST)
Content-Language: en-US
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

Hi,

I'm in the process of putting together a loudness compensation plugin 
for ALSA.  The filtering part is implemented as an external PCM plugin 
and it is, more or less, ready, meaning that you can set its parameters 
via configuration options and it'll happily filter away in real time. 
I'm trying now to create a matching mixer plugin, to allow on-the-fly 
adjustment of the parameters, and I'm not sure what the best way of 
accomplishing that would be.  My main concerns are:

1. I've figured out how to create a basic external control plugin, that 
would allow me to expose a set of controls, which the user can fiddle 
with, using alsamixer et al., but what would be the best way of 
communicating changes in the values to the PCM plugin?  I could imagine 
using methods external to ALSA, such as a file with stored values, which 
the ctl plugin updates and which the PCM plugin monitors for changes, or 
perhaps I could try to open the mixer from inside the PCM plugin, set 
callbacks for each of its elements and enter a 
snd_mixer_wait/snd_mixer_handle_events loop, in a separate thread of 
course.  Is there reason to prefer one way over the other?  Perhaps 
there is a better way, I'm not aware of?

2. I'd like to support event subscription/notification, but I'm not sure 
how to make that work.  My understanding (from searching the net and 
looking at ALSA's source), is that I need to provide some sort of file 
descriptor, which the subscribing code can poll, so as to block until 
there's an update.  Since I have no obvious candidates for such a file, 
I've tried creating a pipe, handing one end to the control plugin upon 
initialization and then writing single bytes to the other end when 
there's a change in one of the controls.  This works but, as far as I 
can see, the pipe is never actually read from, from the subscribing 
code, so that I would have to manually read from it somehwere, say in 
the read_event callback, in order to flush it.  In the end, I'll 
probably use the descriptor from an inotify watch on the file where the 
plugin stores the control settings, but is this a valid approach 
overall?  Is there some documentation specifying the exact way in which 
poll descriptors are handled by ALSA (in the case of an extrnal CTL 
plugin), that I've missed?  If not, are my assumptions above (that the 
descriptor is only polled and that its contents are never actually read) 
correct?

3. Finally, and although this is not essential, I'd like to provide 
metadata for some controls, to support dB ranges, as that's the most 
natural way to set them.  I see hints that this is supported for 
external control plugins (SND_CTL_EXT_ACCESS_TLV_READ/WRITE, the 
snd_ctl_ext_tlv_rw_t callback), but I'm not sure how to implement it. Is 
it documented somewhere?  If not, could someone describe the basic approach?

Thanks,
Dimitris
