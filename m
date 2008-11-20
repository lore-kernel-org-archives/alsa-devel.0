From: Pierre Vanhoucke <pierre.vanhoucke@skynet.be>
Subject: Alsa "short read"
Date: Thu, 20 Nov 2008 12:35:55 +0100
Message-ID: <1227180955.7968.5.camel@pierre-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by alsa0.perex.cz (Postfix) with ESMTP id B05D224149
	for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2008 12:35:56 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

Is there anybody out there who can help me to answer the following
questions:

I have converted an application called Linrad
( http://www.nitehawk.com/sm5bsz/linuxdsp/linrad.htm ) from OSS to ALSA.
Linrad is a remarkable DSP application used worldwide by many
radio-hams.

I am facing hereby a problem with a "short read" :

An ALSA device is opened in blocking mode:

*********************************************
err=snd_pcm_open(&rx_ad_handle, 
                 rx_sndin_plughw_pcm_name,
                 SND_PCM_STREAM_CAPTURE,
                 0);
*********************************************
When I subsequently read the device with following statement I sometimes
get a "short read":
********************************************
      err=snd_pcm_readi(rx_ad_handle,rxin_isho, rxad.block_frames);
      if((unsigned int)err != rxad.block_frames)
        {
        if(err == -EPIPE)           // EPIPE, try recovery  
          { 
          err= snd_pcm_recover(rx_ad_handle, err, 0);
          if(err < 0)lirerr(1108);  // recovery failed
          }
        else 
          {
          if(err < 0)             
            {
            lirerr(1113);           // catch all
            }
          else
            {
            lirerr(1116);            // short read
            }
          }
        }
      }
**************************************************

Here are my questions:

1. How is it possible to get a "short read" in blocking mode ?
I would think that in blocking mode the control is only returned after
the read is completed.

2. What are the possible causes for a "short read" ?

3. What can be done to  avoid a "short read" ?

4. How am I supposed to recover from a "short read"?


Best regards,

Pierre Vanhoucke/ ON5GN
