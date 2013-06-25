From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: Re: [PATCH 2/2 V2] ALSA: hda - Add cache connection
	info
Date: Tue, 25 Jun 2013 02:29:58 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC48901183426D@SHSMSX104.ccr.corp.intel.com>
References: <1372079419-31903-1-git-send-email-xingchao.wang@linux.intel.com>
 <1372079419-31903-2-git-send-email-xingchao.wang@linux.intel.com>
 <s5hip13vhjb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E23D26518E
 for <alsa-devel@alsa-project.org>; Tue, 25 Jun 2013 04:30:03 +0200 (CEST)
In-Reply-To: <s5hip13vhjb.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Wang Xingchao <xingchao.wang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

I revised the patch and will send you now. The "Cache connection" name was replaced with "In-driver connection".
In my test with only one HDMI monitor connected at second pin, it looks like:

Node 5/7:
  Connection: 0
  In-driver Connection: 3
     0x02 0x03 0x04

Node 6:
  Connection: 3
     0x02* 0x03 0x04

Thanks
--xingchao
> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Monday, June 24, 2013 8:07 PM
> To: Wang Xingchao
> Cc: alsa-devel@alsa-project.org; Wang, Xingchao
> Subject: Re: [PATCH 2/2 V2] ALSA: hda - Add cache connection info
> 
> At Mon, 24 Jun 2013 09:10:19 -0400,
> Wang Xingchao wrote:
> >
> > Pin's connection list may change dynamically with hot-plug event on
> > Intel Haswell chip. Users would see connections be "0" in codec#.
> > when play audio on this pin, software choose connections from cache.
> > So add Cache connection info to avoid confuse.
> >
> > Signed-off-by: Wang Xingchao <xingchao.wang@linux.intel.com>
> > ---
> >  sound/pci/hda/hda_proc.c | 17 ++++++++++++++++-
> >  1 file changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/sound/pci/hda/hda_proc.c b/sound/pci/hda/hda_proc.c index
> > 0fee8fa..403589c 100644
> > --- a/sound/pci/hda/hda_proc.c
> > +++ b/sound/pci/hda/hda_proc.c
> > @@ -504,6 +504,8 @@ static void print_conn_list(struct snd_info_buffer
> *buffer,
> >  			    int conn_len)
> >  {
> >  	int c, curr = -1;
> > +	const hda_nid_t *list;
> > +	int cache_len;
> >
> >  	if (conn_len > 1 &&
> >  	    wid_type != AC_WID_AUD_MIX &&
> > @@ -511,7 +513,7 @@ static void print_conn_list(struct snd_info_buffer
> *buffer,
> >  	    wid_type != AC_WID_POWER)
> >  		curr = snd_hda_codec_read(codec, nid, 0,
> >  					  AC_VERB_GET_CONNECT_SEL, 0);
> > -	snd_iprintf(buffer, "  Connection: %d\n", conn_len);
> > +	snd_iprintf(buffer, "  Raw Connection: %d\n", conn_len);
> 
> Don't change the existing entry.  It'll break the user-space tools that read the
> proc contents.
> 
> >  	if (conn_len > 0) {
> >  		snd_iprintf(buffer, "    ");
> >  		for (c = 0; c < conn_len; c++) {
> > @@ -521,6 +523,19 @@ static void print_conn_list(struct snd_info_buffer
> *buffer,
> >  		}
> >  		snd_iprintf(buffer, "\n");
> >  	}
> > +
> > +	/* Get Cache connections info */
> > +	cache_len = snd_hda_get_conn_list(codec, nid, &list);
> > +	if (cache_len != conn_len
> > +			|| memcmp(list, conn, conn_len)) {
> > +		snd_iprintf(buffer, "  Cache Connection: %d\n", conn_len);
> 
> Must be cache_len.
> 
> Also "Cache connection" might be a bit misleading.  In this case, it's not
> cached but used as alternative in driver.  "In-driver connection"
> or such?  English-native people can give better advice...
> 
> > +		if (cache_len > 0) {
> > +			snd_iprintf(buffer, "    ");
> > +			for (c = 0; c < conn_len; c++)
> 
> Must be cache_len, too.
> 
> 
> thanks,
> 
> Takashi
> 
> 
> > +				snd_iprintf(buffer, " 0x%02x", list[c]);
> > +			snd_iprintf(buffer, "\n");
> > +		}
> > +	}
> >  }
> >
> >  static void print_gpio(struct snd_info_buffer *buffer,
> > --
> > 1.8.1.2
> >
