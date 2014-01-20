From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: External sound card issue
Date: Mon, 20 Jan 2014 13:45:26 +0100
Message-ID: <52DD1A66.9050909@ladisch.de>
References: <CAEiHY5j=K874m_Jk7ws4eOqts855oSHqY0HUrp_A5WwxFoDr=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 7C60F26165F
 for <alsa-devel@alsa-project.org>; Mon, 20 Jan 2014 13:45:39 +0100 (CET)
In-Reply-To: <CAEiHY5j=K874m_Jk7ws4eOqts855oSHqY0HUrp_A5WwxFoDr=Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ionica Bizau <bizauionica@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ionica Bizau wrote:
> I have just bought an external sound card: Asus Xonar U7
>
>     cannot load mixer controls: Broken pipe

This looks like a bug in the device's firmware.

Can you at least read the list of controls ("amixer -c1 controls")?
Are there some controls that you are able to access (try
"amixer -c1 cget name='xxx'" for each one)?


Regards,
Clemens
