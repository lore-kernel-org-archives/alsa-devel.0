From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: snd-hda-intel on fj amilo m3438g
Date: Thu, 12 Jan 2006 15:12:55 -0500
Message-ID: <1137096776.2370.44.camel@mindpipe>
References: <200601121900.51968.inyourface@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200601121900.51968.inyourface@gmx.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: mase <inyourface@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-01-12 at 19:00 +0100, mase wrote:
> hi!
> can you please help me?
> i have a fujitsu siemens amilo m3438g notebook with a
> realtek alc880 (windows says so) soundchip.
> the sound output works fine, but none of the inputs,
> neither built-in mic, nor external mic.
> the notebook has 2 jacks:
> 1 for mic and 1 for headphones shared with spdif.
> i have tested different models: auto, w810 F1734,uniwill, asus,
> z71v, 3stack

The obvious first one to try would have been "fujitsu".

Also make sure to check /sys/module/snd_hda_intel/parameters/model to
make sure it is seeing the module options.

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
