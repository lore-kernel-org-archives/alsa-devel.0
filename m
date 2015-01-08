From: Petr Kulhavy <petr@barix.com>
Subject: AES/SPDIF channel status bits in ALSA
Date: Thu, 08 Jan 2015 14:14:10 +0100
Message-ID: <54AE82A2.7070100@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com
 [209.85.212.175])
 by alsa0.perex.cz (Postfix) with ESMTP id BBFCE260410
 for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2015 14:14:12 +0100 (CET)
Received: by mail-wi0-f175.google.com with SMTP id l15so3158195wiw.2
 for <alsa-devel@alsa-project.org>; Thu, 08 Jan 2015 05:14:12 -0800 (PST)
Received: from [192.168.11.22] (84-72-111-243.dclient.hispeed.ch.
 [84.72.111.243])
 by mx.google.com with ESMTPSA id wa5sm6131884wjc.8.2015.01.08.05.14.10
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 08 Jan 2015 05:14:11 -0800 (PST)
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

is there a way to get the channel status bits information from an AES or =

SPDIF input interface through ALSA and read it in userspace?
I'm trying to solve some issues with the channel status bits sent from a =

custom hardware and finding a way to analyse the channel status info.

Regards
Petr

-- =

Petr Kulhavy, MSc
System Architect

*BARIX*

petr@barix.com <mailto:petr@barix.com> | Skype: brain.barix

Barix AG, Seefeldstrasse 303 | 8008 Zurich, Switzerland
T +41 43 43322 11 | www.barix.com <http://www.barix.com>

You have received this email because of your relationship Barix AG and =

its affiliated companies. Barix AG and its affiliated companies do not =

sell or exchange email addresses, or any other personal contact =

information provided by you with any third parties. All email =

distributions are managed and controlled by Barix AG and its affiliated =

companies.
Barix AG, Seefeldstr. 303, 8008 Z=FCrich, Switzerland. Company Reg. No: =

CH-020.3.023.869-8, VAT Reg. No: CHE-105.687.663.
