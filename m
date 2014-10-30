From: dE <de.techno@gmail.com>
Subject: Re: opengl 'leaking' sound to input.
Date: Thu, 30 Oct 2014 21:16:08 +0530
Message-ID: <54525D40.8040104@gmail.com>
References: <545209CA.1070307@gmail.com> <54521333.2060105@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f53.google.com (mail-pa0-f53.google.com
 [209.85.220.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 25AD92605AF
 for <Alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 16:46:35 +0100 (CET)
Received: by mail-pa0-f53.google.com with SMTP id kx10so5721323pab.12
 for <Alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 08:46:34 -0700 (PDT)
Received: from [192.168.1.2] ([117.208.64.119])
 by mx.google.com with ESMTPSA id pc8sm7493590pdb.54.2014.10.30.08.46.32
 for <Alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Thu, 30 Oct 2014 08:46:33 -0700 (PDT)
In-Reply-To: <54521333.2060105@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/30/14 16:00, Clemens Ladisch wrote:
> dE wrote:
>> I'm trying to record audio from the analog input device of my card,
>> but whenever there seems to be some graphics intensive activity like
>> glxgears, OpenGL assisted window manager, audacity graphs etc...
>> a noise appears in the recording which sounds like some kind of
>> sparking disturbance.
> Sudden changes in power consumption will affect the voltage on the
> power lines.  (If the GPU is powered only from the mainboard, there is
> not much your PSU could do against this.)  Your card (whatever it is)
> apparently is not properly isolated against such fluctuations.
>
>
> Regards,
> Clemens

The GPU takes very less power (motherboard embedded), in contrast the 
CPU takes 80W and usually it'll take at least 15W (CPU scaling).

But with the CPU fluctuations, there's no nose. It has to do only with 
OpenGL. If I try VESAfb with software OpenGL, there's no noise.
