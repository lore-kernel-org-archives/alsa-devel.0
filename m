From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Re: Para-virtualized audio drivers
Date: Thu, 20 Oct 2016 17:02:42 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB60552C5EC44@BGSMSX104.gar.corp.intel.com>
References: <85DFEED57DC57344B2483EF7BF8CB60552C5B457@BGSMSX104.gar.corp.intel.com>
 <s5hpomvghyu.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 698672606F8
 for <alsa-devel@alsa-project.org>; Thu, 20 Oct 2016 19:02:46 +0200 (CEST)
In-Reply-To: <s5hpomvghyu.wl-tiwai@suse.de>
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
Cc: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>>
>> I am thinking to develop pv-audio-frontend (running on Dom1) and
>> pv-audio-backend (running on Dom0) drivers all at kernel level.
>> Backend driver owns the hardware. Frontend driver communicates with
>> backend driver using XENbus framework just like storage and network PV
>> drivers.
>>
>> Before I start, I wanted to check if there is any other
>> work that has been done which I can take as base ?
>
>I don't know of any other existing implementation for Xen.  The
>question would be rather how you would implement the backend.
>

My thinking is to have backend driver at kernel level. The backend
driver would receive requests from frontend driver. I agree that the
previous effort was to develop it in user space.

>Is it about Intel hardware as Liam has been working on?  Or is it

Liam's work is different.

>targeted as a generic Xen stuff like the patches you mentioned in the
>above?  The patchset above was about the user-space backend, IIRC.
>

I am trying to develop generic PV audio drivers for XEN. I see people 
have developed PV Storage and Network drivers in XEN and they
are up-streamed. So I was thinking to do that for audio as well.

Do you recall why the above patchset was not merged ?
any limitations or was it incomplete ? 

Regards,
Rakesh


>
>Takashi
