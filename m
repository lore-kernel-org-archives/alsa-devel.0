From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: opengl 'leaking' sound to input.
Date: Thu, 30 Oct 2014 11:30:11 +0100
Message-ID: <54521333.2060105@ladisch.de>
References: <545209CA.1070307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 3355A260629
 for <Alsa-devel@alsa-project.org>; Thu, 30 Oct 2014 11:30:13 +0100 (CET)
In-Reply-To: <545209CA.1070307@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: dE <de.techno@gmail.com>, Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

dE wrote:
> I'm trying to record audio from the analog input device of my card,
> but whenever there seems to be some graphics intensive activity like
> glxgears, OpenGL assisted window manager, audacity graphs etc...
> a noise appears in the recording which sounds like some kind of
> sparking disturbance.

Sudden changes in power consumption will affect the voltage on the
power lines.  (If the GPU is powered only from the mainboard, there is
not much your PSU could do against this.)  Your card (whatever it is)
apparently is not properly isolated against such fluctuations.


Regards,
Clemens
