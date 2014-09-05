From: Petr Kulhavy <petr@barix.com>
Subject: How to properly handle variable samplerate?
Date: Fri, 05 Sep 2014 18:20:42 +0200
Message-ID: <5409E2DA.2090403@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f176.google.com (mail-we0-f176.google.com
 [74.125.82.176])
 by alsa0.perex.cz (Postfix) with ESMTP id 223522619EA
 for <alsa-devel@alsa-project.org>; Fri,  5 Sep 2014 18:20:44 +0200 (CEST)
Received: by mail-we0-f176.google.com with SMTP id q59so12008754wes.21
 for <alsa-devel@alsa-project.org>; Fri, 05 Sep 2014 09:20:43 -0700 (PDT)
Received: from [192.168.11.22] (84-72-111-243.dclient.hispeed.ch.
 [84.72.111.243])
 by mx.google.com with ESMTPSA id ky3sm1884598wjb.39.2014.09.05.09.20.42
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 05 Sep 2014 09:20:42 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I'm developing an audio stream player application with ALSA output, the =

player has a large software buffer. The trouble is that the stream can =

potentially change the sampling rate (e.g. streaming RTP from a VLC =

playlist created from different MP3 songs). How to properly handle this?

I'm thinking of the following concept:
The codec feeds data into the software buffer together with markers for =

sample rate changes. The ALSA playback is asynchronous, using a callback =

function feeding the data from the software buffer into ALSA. If a =

samplerate marker is hit the new rate is set.

Can the sample rate be set from a callback? What other constraints are =

there? And how does the HW FIFO handle samplerate changes?
Or is there a better way of implementing?

Thanks a lot!
Petr

-- =

Petr Kulhavy, MSc
System Architect

*BARIX*

petr@barix.com <mailto:petr@barix.com> | Skype: brain.barix

Barix AG, Seefeldstrasse 303 | 8008 Zurich, Switzerland
T +41 43 43322 11 | www.barix.com <http://www.barix.com>

You have received this email because of your relationship Barix AG and
its affiliated companies. Barix AG and its affiliated companies do not
sell or exchange email addresses, or any other personal contact
information provided by you with any third parties. All email
distributions are managed and controlled by Barix AG and its affiliated
companies.
Barix AG, Seefeldstr. 303, 8008 Z=FCrich, Switzerland. Company Reg. No:
CH-020.3.023.869-8, VAT Reg. No: CHE-105.687.663.
