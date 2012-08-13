From: Ian Minett <ian_minett@creativelabs.com>
Subject: Re: [PATCHv2.1-CA0132 HDA Codec 2/2] Add DSP loader
	code to CA0132 codec
Date: Mon, 13 Aug 2012 16:04:47 -0700
Message-ID: <OFC483CB74.F20F077C-ON88257A59.007AFBE2-88257A59.007EC813@cli.creative.com>
References: <s5h7gt9hmpe.wl%tiwai@suse.de>	<1344665872-15537-1-git-send-email-ian_minett@creativelabs.com>
 <1344665872-15537-2-git-send-email-ian_minett@creativelabs.com>
 <s5hobmh9a1f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3939676650013492081=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-outbound2.cli.creative.com
 (smtp-outbound2.cli.creative.com [124.246.64.232])
 by alsa0.perex.cz (Postfix) with ESMTP id C4B14265DB9
 for <alsa-devel@alsa-project.org>; Tue, 14 Aug 2012 00:35:15 +0200 (CEST)
In-Reply-To: <s5hobmh9a1f.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============3939676650013492081==
Content-type: multipart/related;
	Boundary="0__=07BBF0CADFE97D728f9e8a93df938690918c07BBF0CADFE97D72"

--0__=07BBF0CADFE97D728f9e8a93df938690918c07BBF0CADFE97D72
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: quoted-printable






>So the point is to concentrate only on DMA transfer stuff at first.
>Once after confirmed it's working, continue to the new DSP features.,

Ok, that makes sense.

>A remaining question is:
>- what is the condition to operate DSP transfer?  Must all PCM streams=

>  be closed and streams are released?

Yes, all PCM streams need to be closed and released for the DSP transfe=
r.
Since the driver loads the DSP during the init phase, there shouldn't b=
e
any active streams at that time.

- Ian


Notice
The information in this message is confidential and may be legally priv=
ileged.  It is intended
solely for the addressee.  Access to this message by anyone else is una=
uthorized.  If you are not
the intended recipient, any disclosure, copying or distribution of the =
message, or any action taken
by you in reliance on it, is prohibited and may be unlawful.  This emai=
l is for communication
purposes only. It is not intended to constitute an offer or form a bind=
ing agreement.  Our company
accepts no liability for the content of this email, or for the conseque=
nces of any actions taken on
the basis of the information provided.  If you have received this messa=
ge in error,  please delete
it and contact the sender immediately.  Thank you.




                                                                       =
                             
             Takashi Iwai                                              =
                             
             <tiwai@suse.de>                                           =
                             
                                                                       =
                          To 
             08/11/2012 12:12 AM                 Ian Minett <ian_minett=
@creativelabs.com>           
                                                                       =
                          cc 
                                                 alsa-devel@alsa-projec=
t.org                        
                                                                       =
                     Subject 
                                                 Re: [PATCHv2.1-CA0132 =
HDA Codec 2/2] Add DSP       
                                                 loader code to CA0132 =
codec                        
                                                                       =
                             
                                                                       =
                             
                                                                       =
                             
                                                                       =
                             
                                                                       =
                             
                                                                       =
                             




At Fri, 10 Aug 2012 23:17:52 -0700,
Ian Minett wrote:
>
> From: Ian Minett <ian_minett@creativelabs.com>
>
> Draft patch to add new DSP loader code, with calls to load_dsp_xxxx()=
 functions.
>
>
> Signed-off-by: Ian Minett <ian_minett@creativelabs.com>
(snip)
> @@ -2113,9 +1994,7 @@ static int dma_set_state(struct dma_engine *dma=
, enum dma_state state)
>                        return 0;
>            }
>
> -          azx_pcm_trigger(dma->substream, cmd);
> -
> -          return 0;
> +          return load_dsp_trigger(dma->codec->bus, cmd);

Maybe we just need to pass a boolean to start/stop.

>  static unsigned int dma_get_buffer_size(struct dma_engine *dma)
> @@ -2128,15 +2007,6 @@ static unsigned int *dma_get_buffer_addr(struc=
t dma_engine *dma)
>            return dma->m_buffer_addr;
>  }
>
> -static int dma_free_buffer(struct dma_engine *dma)
> -{
> -          azx_pcm_hw_free(dma->substream);
> -          azx_pcm_close(dma->substream);
> -          kfree(dma->substream->runtime);
> -          dma->substream->runtime =3D NULL;
> -          return 0;

OK, I forgot that a cleanup callback is also required...

> +          dma_engine->codec =3D codec;
> +          dma_convert_to_hda_format(format, &hda_format);
> +          dma_engine->m_converter_format =3D hda_format;
> +          dma_engine->m_buffer_size =3D
> +                ovly ? DSP_DMA_WRITE_BUFLEN_OVLY : DSP_DMA_WRITE_BUF=
LEN_INIT;
> +          dma_engine->m_buffer_addr =3D kzalloc(dma_engine->m_buffer=
_size,
> +                                                              GFP_KE=
RNEL);

Allocating the DMA transfer buffer via kmalloc doesn't work.
The buffer must be aligned and coherent.  Thus it's better to let the
buffer management in hda_intel.c.

In the end, what we need in hda_intel.c are:
- a function to allocate buffer, setup BDL and DMA, return the pointer
- a function to start/stop transfer
- a function to clean up DMA, release the buffer

Thus the hda_bus_ops will gain the following ops:

/* bus operators */
struct hda_bus_ops {
...
#ifdef CONFIG_SND_HDA_LOAD_DSP
             /* prepare DSP transfer */
             void *(*load_dsp_prepare)(struct hda_codec *codec, unsigne=
d int format,
                                                   unsigned int byte_si=
ze);
             /* start/stop DSP transfer */
             void (*load_dsp_trigger)(struct hda_codec *codec, bool sta=
rt);
             /* clean up DSP transfer */
             void (*load_dsp_cleanup)(struct hda_codec *codec, void *bu=
f,
                                                  unsigned int byte_siz=
e);
#endif
};

Then define the function like

static inline void *
snd_hda_codec_load_dsp_prepare(struct hda_codec *codec, unsigned int fo=
rmat,
                                                 unsigned int size)
{
             return codec->bus->ops.load_dsp_prepare(codec, format, siz=
e);
}

and so on.

A remaining question is:
- what is the condition to operate DSP transfer?  Must all PCM streams
  be closed and streams are released?


Takashi

ForwardSourceID:NT0001D94A=

--0__=07BBF0CADFE97D728f9e8a93df938690918c07BBF0CADFE97D72
Content-type: image/gif;
	name="graycol.gif"
Content-Disposition: inline; filename="graycol.gif"
Content-ID: <10__=07BBF0CADFE97D728f9e8a9@cli.creative.com>
Content-transfer-encoding: base64

R0lGODlhEAAQAKECAMzMzAAAAP///wAAACH5BAEAAAIALAAAAAAQABAAAAIXlI+py+0PopwxUbpu
ZRfKZ2zgSJbmSRYAIf4fT3B0aW1pemVkIGJ5IFVsZWFkIFNtYXJ0U2F2ZXIhAAA7

--0__=07BBF0CADFE97D728f9e8a93df938690918c07BBF0CADFE97D72
Content-type: image/gif;
	name="pic16413.gif"
Content-Disposition: inline; filename="pic16413.gif"
Content-ID: <20__=07BBF0CADFE97D728f9e8a9@cli.creative.com>
Content-transfer-encoding: base64

R0lGODlhWABDALP/AAAAAK04Qf79/o+Gm7WuwlNObwoJFCsoSMDAwGFsmIuezf///wAAAAAAAAAA
AAAAACH5BAEAAAgALAAAAABYAEMAQAT/EMlJq704682770RiFMRinqggEUNSHIchG0BCfHhOjAuh
EDeUqTASLCbBhQrhG7xis2j0lssNDopE4jfIJhDaggI8YB1sZeZgLVA9YVCpnGagVjV171aRVrYR
RghXcAGFhoUETwYxcXNyADJ3GlcSKGAwLwllVC1vjIUHBWsFilKQdI8GA5IcpApeJQt8L09lmgkH
LZikoU5wjqcyAMMFrJIDPAKvCFletKSev1HBw8KrxtjZ2tvc3d5VyKtCKW3jfz4uMKmq3xu4N0nK
BVoJQmx2LGVOmrqNjjJf2hHAQo/eDwJGTKhQMcgQEEAnEjFS98+RnW3smGkZU6ncCWav/4wYOnAI
TihRL/4FEwbp28BXMMcoscQCVxlepL4IGDSCyJyVQOu0o7CjmLN50OZlqWmyFy5/6yBBuji0AxFR
M00oQAqNIstqI6qKHUsWRAEAvagsmfUEAImyxgbmUpJk3IklNUtJOUAVLoUr1+wqDGTE4zk+T6FG
uQb3SizBCwatiiUgCBN8vrz+zFjVyQ8FWkOlg4NQiZMB5QS8QO3mpOaKnL0Z2EKvNMSILEThKhCg
zMKPVxYJh23qm9KNW7pArPynMqZDiErsTMqI+LRi3QAgkFUbXpuFKhSYZALd0O5RKa2z9EYKBbpb
qxIKsjUPRgD7I2XYV6wyrOw92ykExP8NW4URhknC5dKGE4v4NENQj2jXjmfNgOZDaXb5glRmXQ33
YEWQYNcZFnrYcIQLNzyTFDQNkXIff0ExVlY4srziQk43inZgL4rwxxINMvpFFAz1KOODHiu+4aEw
NEjFl5B3JIKWKF3k6I9bfUGp5ZZcdunll5IA4cuHvQQJ5gcsoCWOOUwgltIwAKRxJgbIkJAQZEq0
2YliZnpZZ4BH3CnYOXldOUOfQoYDqF1LFHbXCrO8xmRsfoXDXJ6ChjCAH3QlhJcT6VWE6FCkfCco
CgrMFsROrIEX3o2whVjWDjoJccN3LdggSGXLCdLEgHr1lyU3O3QxhgohNKXJCWv8JQr/PDdaqd6w
2rj1inLiGeiCJoDspAoQlYE6QWLSECehcWIYxIQES6zhbn1iImTHEQyqJ4eIxJJoUBc+3CbBuwZE
V5cJPPkIjFDdeEabQbd6WgICTxiiz0f5dBKquXF6k4senwEhYGnKEFJeGrxUZy8dB8gmAXI/sPvH
ESfCwVt5hTgYiqQqtdRNHQIU1PJ33ZqmzgE90OwLaoJcnMop1WiMmgkPHQRIrwgFuNV90A3doNKT
mrKIN07AnGcI9BQjhCBN4RfA1qIZnMqorJCogKfGQnxSCDilTVIA0yl5ciTovgLuBDKFUDE9aQcw
9SA+rjSNf9/M1gxrj6VwDTS0IUSElMzBfsj0NFXR2kwsV1A5IF1grLgLL/r1R40BZEnuBWgmQEyb
jqRwSAt6bqMCOFkvKFN2GPPkUzIm/SCF8z8pVzpbjVnMsy0vOr1hw3SaSRUhpY09v0z0J1FnwzPl
fmh+xl4WtR0zGu24I4KbMQm3lnVu2oNWxI9W/lcyzA+mCKF4DBikxb/+UWtOGRiFP8qEwAayIgIA
Ow==

--0__=07BBF0CADFE97D728f9e8a93df938690918c07BBF0CADFE97D72
Content-type: image/gif;
	name="ecblank.gif"
Content-Disposition: inline; filename="ecblank.gif"
Content-ID: <30__=07BBF0CADFE97D728f9e8a9@cli.creative.com>
Content-transfer-encoding: base64

R0lGODlhEAABAIAAAAAAAP///yH5BAEAAAEALAAAAAAQAAEAAAIEjI8ZBQA7

--0__=07BBF0CADFE97D728f9e8a93df938690918c07BBF0CADFE97D72--


--===============3939676650013492081==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3939676650013492081==--
