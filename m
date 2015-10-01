From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [RFC] MIDI over Bluetooth Low Energy
Date: Thu, 1 Oct 2015 13:27:15 +0200
Message-ID: <560D1893.6040509@ladisch.de>
References: <CAGrhNMyY7rJVZ35p5P5FnGvJPYZuKndau1vNY5k+GCHHYzZtzQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id D8E4426666D
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2015 13:27:52 +0200 (CEST)
In-Reply-To: <CAGrhNMyY7rJVZ35p5P5FnGvJPYZuKndau1vNY5k+GCHHYzZtzQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Felipe Tonello <eu@felipetonello.com>, alsa-devel@alsa-project.org, linux-bluetooth@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Felipe Tonello wrote:
> I am planning to start the support of MIDI BLE profile[1].
>
> I suggest two main goals:
>  * To be transparent to applications, i.e., use rawmidi and sequencer
> ALSA interfaces to interact.
>  * To support peripheral and central BLE roles.
>
> My question is: what is the best way possible of doing it?

Just write a (user-space) sequencer client.

> [...]
> They all have the problem of context switching between bluez plugin
> and alsa midi driver.

Why would context switches be a problem?


Regards,
Clemens
