From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Question on compress offload framework memory
	corruption
Date: Thu, 19 Dec 2013 11:42:02 +0100
Message-ID: <52B2CD7A.7070803@ladisch.de>
References: <63ac7c9c1f4ac8d8ef0ed9587fd1cf5f.squirrel@www.codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 644CF26530B
 for <alsa-devel@alsa-project.org>; Thu, 19 Dec 2013 11:43:02 +0100 (CET)
In-Reply-To: <63ac7c9c1f4ac8d8ef0ed9587fd1cf5f.squirrel@www.codeaurora.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, gsantosh@codeaurora.org
List-Id: alsa-devel@alsa-project.org

Re-sending with Liam's correct address (which is _not_ clemens@ladisch.de).

gsantosh@codeaurora.org wrote:
> Hi,
>
> I have following questions in the compressed offload framework API.
>
> static int soc_compr_set_params_fe(struct snd_compr_stream *cstream,
> 					struct snd_compr_params *params)
> {
> ...
> 	hw_params = kzalloc(sizeof(*hw_params), GFP_KERNEL);
> 	if (hw_params == NULL)
> 		return -ENOMEM;
> /*1st question is, what is the use of above allocated memory I do not see
> this being used in this function*/
>
> ...
>
> 	memcpy(&fe->dpcm[fe_substream->stream].hw_params, params,
> 			sizeof(struct snd_pcm_hw_params));
>
> /* 2nd question is
> in above memcpy there is parameter mismatch
> &fe->dpcm[fe_substream->stream].hw_params is of structure type struct
> snd_pcm_hw_params
>
> params argument is of the structure type struct snd_compr_params
> the definition of the two structures are different, how this is working?
> this will over right the destination with junk value which will return
> in error when this memory is accessed, after memcpy this cpu_dai hw_params
> returing with EINVAL error, please explain why this is done this way.
> */
>
> ...
>
> }
>
> Regards,
> Santosh M G.
