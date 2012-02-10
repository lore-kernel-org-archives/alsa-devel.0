From: Stephen Warren <swarren@nvidia.com>
Subject: Re: ALSA 1.0.25 broke AC3 passthrough?
Date: Thu, 09 Feb 2012 20:09:26 -0800
Message-ID: <4F349876.6080109@nvidia.com>
References: <CANpj82+DPJGg1vUvm-otVEWEeXwK8zOy4ZAGjFH81oc5n51CTw@mail.gmail.com>
	<4F30BABD.10504@nvidia.com>
	<CANpj82JTMW-nm4r_Z3JgK_Ft7oimr84Yz+-8m-41d1pwEvtfoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 1B9BC24332
	for <alsa-devel@alsa-project.org>; Fri, 10 Feb 2012 05:09:29 +0100 (CET)
In-Reply-To: <CANpj82JTMW-nm4r_Z3JgK_Ft7oimr84Yz+-8m-41d1pwEvtfoQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jean-Yves Avenard <jyavenard@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 02/09/2012 03:01 AM, Jean-Yves Avenard wrote:
> [Re-send to include distribution list]
> 
> Hi
> 
> On 7 February 2012 16:46, Stephen Warren <swarren@nvidia.com> wrote:
> 
>> Are you able to regress this to a smaller window? I did do some rework a
>> while back on the HDA driver to support newer GeForce GPUs' audio HW
>> better, and this potentially had impact on bitstream pass-through,
>> although it seemed to work at the time. Commits were:
> 
> I'm not sure what you mean by regress to a smaller window.

You'd mentioned that this problem was present in ALSA 1.0.25, but wasn't
in some earlier release. Potentially a lot changed between those two
releases. It'd be nice if you could try compiling a number of
intermediate versions of the ALSA driver to try and more precisely
locate the change that caused the issue. "git bisect" on the ALSA driver
repository might be useful here.

-- 
nvpublic
