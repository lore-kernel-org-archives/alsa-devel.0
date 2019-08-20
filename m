From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [BUG] bdw-rt5650 DSP boot timeout
Date: Mon, 19 Aug 2019 19:55:34 -0500
Message-ID: <e185a97e-1f09-6706-e468-3a5475d5a322@linux.intel.com>
References: <CACJJ=pxPm7dRUE534hDWy2tN3dGYDyrgU8JKqett=wOQx+nWCQ@mail.gmail.com>
 <39533fe5-c060-7a07-c910-74b83eee53c4@linux.intel.com>
 <ac7bcb42e40ac12d9924fd65c3e2c68b9b11b093.camel@linux.intel.com>
 <37ede7ea-e760-eac9-a1d5-0eb8e3bff3cb@linux.intel.com>
 <CACJJ=pyb==xWqKMB-gAzW7-FCFgEU7Rm+b-CL-ANO-eorDKy=A@mail.gmail.com>
 <356b3f4eacb43f23c40c4cd8e3c54ae9514a34c6.camel@linux.intel.com>
 <7e08e45d-7cec-9fdd-36c5-5e82632968f8@linux.intel.com>
 <CACJJ=pzcMCaOvHMVhmYKKL2Z45-XdrBB9FT8VjSzX_obVtKzyw@mail.gmail.com>
 <d80c2f4d-b5f4-5bbe-9529-36b9859ab8be@linux.intel.com>
 <CACJJ=pxokT5z+U=nM9QcUVxCk84998ugM5J89U28k=CVGMjG=w@mail.gmail.com>
 <E7B1D079BA13FB44A978CC8F69C7D6A9606FC567@SHSMSX106.ccr.corp.intel.com>
 <d0131c02-3477-8390-e0c6-b37b142169e8@intel.com>
 <CACJJ=pwsV2U669QqB0E05XxWppfXR81TrDCkEunfSefJ5Mij7w@mail.gmail.com>
 <CAOReqxg+J=Sa1o+1Cmo7hrh136k2tUFCaqxPgrXE=DKfwsbTfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 95F53F802E0
 for <alsa-devel@alsa-project.org>; Tue, 20 Aug 2019 02:55:38 +0200 (CEST)
In-Reply-To: <CAOReqxg+J=Sa1o+1Cmo7hrh136k2tUFCaqxPgrXE=DKfwsbTfw@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Curtis Malainey <cujomalainey@google.com>, Jon Flatley <jflat@chromium.org>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Ross Zwisler <zwisler@google.com>, Jie Yang <yang.jie@linux.intel.com>, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, "benzh@chromium.org" <benzh@chromium.org>, "cujomalainey@chromium.org" <cujomalainey@chromium.org>
List-Id: alsa-devel@alsa-project.org


>>
> My recommendation would be to look at the machine driver and see if
> its making additional calls to the DSP driver that is not made in
> other machine drivers such as the bdw-rt5677 (Samus.) That might
> indicate an additional code path that might be getting exercised in
> your context that isn't used in samus which is causing your problems.
> If you find something you can always copy it over to samus to see if
> it causes the same breakage. So yes definitely look. Usually the
> suspend/resume paths aren't that long, but I would search the whole
> machine driver for anything that can alter state.

The only significant difference I see in the machine drivers is that the 
clock dividers are smaller in this bdw-rt5660 case, the bitclock is 4.8 
MHz v. 2.4 MHz in the other bdw-rt5677. It's not very clear to me why 
there is a need to have different clock and SSP settings, but since the 
patch that was suggested to be reverted touches the clock generation 
maybe there's a connection?
