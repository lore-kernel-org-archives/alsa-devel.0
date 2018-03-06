From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v3 07/25] ASoC: qcom: qdsp6: Add support to
	Q6ADM
Date: Tue, 6 Mar 2018 09:26:42 +0000
Message-ID: <bb87bd34-ab81-e297-3bd4-3e52f6859e34@linaro.org>
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-8-srinivas.kandagatla@linaro.org>
 <20180301212402.GT12864@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id A9E0D2672A7
 for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2018 10:26:43 +0100 (CET)
Received: by mail-wm0-f67.google.com with SMTP id z81so21272413wmb.4
 for <alsa-devel@alsa-project.org>; Tue, 06 Mar 2018 01:26:43 -0800 (PST)
In-Reply-To: <20180301212402.GT12864@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com, linux-arm-msm@vger.kernel.org, plai@codeaurora.org, tiwai@suse.com, lgirdwood@gmail.com, david.brown@linaro.org, robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org, spatakok@qti.qualcomm.com, andy.gross@linaro.org, linux-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Thanks for the review,

On 01/03/18 21:24, Mark Brown wrote:
> On Tue, Feb 13, 2018 at 04:58:19PM +0000, srinivas.kandagatla@linaro.org wrote:
> 
>> +static struct copp *adm_find_copp(struct q6adm *adm, int port_idx,
>> +				  int copp_idx)
>> +{
>> +	struct copp *c;
>> +
>> +	spin_lock(&adm->copps_list_lock);
>> +	list_for_each_entry(c, &adm->copps_list, node) {
>> +		if ((port_idx == c->afe_port) && (copp_idx == c->copp_idx)) {
>> +			spin_unlock(&adm->copps_list_lock);
>> +			return c;
>> +		}
>> +	}
>> +
>> +	spin_unlock(&adm->copps_list_lock);
> 
> We've again got this use of spinlocks here but no IRQ safety - what
> exactly is going on with the locking?  In general all of the locking in
> this stuff is raising very serious alarm bells with me, I don't
> understand what is being protected against what and there's some very
> obvious bugs.  We could probably use some documentation about what the
> locking is supposed to be doing.
> 
I agree, there are locking issues here, Am revisiting them all before I 
send a next version.

>> +	case ADM_CMDRSP_DEVICE_OPEN_V5: {
> 
>> +		copp->id = open->copp_id;
>> +		wake_up(&copp->wait);
>> +	}
>> +	break;
>> +	default:
> 
> This indentation is confusing.
> 
I agree, will fix such instances in next version.

thanks,
srini
