From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [pulseaudio-discuss] ThinkPad T-510 audio output
 mute LED non-workingness
Date: Mon, 04 May 2015 07:37:08 -0300
Message-ID: <1430735828.1027589.262340817.33A79FB3@webmail.messagingengine.com>
References: <20150425013937.GB550@huh.zplane.com>
 <1429974719.3937109.258484493.7D74FAC6@webmail.messagingengine.com>
 <20150426152012.GE550@huh.zplane.com> <s5hvbgiho2o.wl-tiwai@suse.de>
 <CAN8cciZQBRz2Ty3YRt2+3KO9v1BWef-_8FU_d_SsE87mLdgY-w@mail.gmail.com>
 <s5hh9s2gj45.wl-tiwai@suse.de> <20150427135859.GI550@huh.zplane.com>
 <s5ha8xt4hsa.wl-tiwai@suse.de> <20150428000206.GK550@huh.zplane.com>
 <CAN8ccibSH6je=OpX6vOTG9PzETxikmpuX+7PDgiYNrsG+YavNw@mail.gmail.com>
 <20150502160003.GA557@huh.zplane.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 7895B2604B8
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2015 12:37:09 +0200 (CEST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 8B27F2081F
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2015 06:37:08 -0400 (EDT)
In-Reply-To: <20150502160003.GA557@huh.zplane.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Glenn Golden <gdg@zplane.com>, Raymond Yau <superquad.vortex2@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, Alex Hung <alex.hung@canonical.com>, bruno.mueller@gmail.com, ALSA Development Mailing List <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Sat, May 2, 2015, at 13:00, Glenn Golden wrote:
> Henrique: Can you comment on how best to proceed further here? Let me know if

Please attach the full acpidump (use a recent enough acpidump utility, please) to the bugzilla report and reply to this thread after you did so.  Also attach the output of dmidecode.

Please make sure to XXXX-out any UUIDs and serial numbers in the dmidecode output before you attach it to the bugzilla report.

That should tell us which interfaces are really available in the ACPI firmware for the laptop, regardless of any possible bugs in thinkpad-acpi.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
