From: Carlo Wood <carlo@alinoe.com>
Subject: snd_pcm_mmap_begin returns 0 but sets areas to NULL
Date: Tue, 22 Jul 2003 15:51:58 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030722135158.GA12258@alinoe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Is it ever allowed that:

    snd_pcm_channel_area_t const* areas;
    snd_pcm_uframes_t offset;
    snd_pcm_uframes_t size = period_size;
    if (size > 0)
    {
      snd_pcm_uframes_t frames = size;
      int err = snd_pcm_mmap_begin(handle, &areas, &offset, &frames);

returns err == 0, but results in areas == NULL ?

Or is that a bug in alsa?

-- 
Carlo Wood <carlo@alinoe.com>


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
